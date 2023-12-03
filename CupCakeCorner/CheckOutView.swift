//
//  CheckOutView.swift
//  CupCakeCorner
//
//  Created by A.f. Adib on 11/22/23.
//

import SwiftUI

struct CheckOutView: View{
    
    @ObservedObject var order : Order
    
    @State private var confoMsg = ""
    @State private var showConfo = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height : 233)
                
                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                    
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }.padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showConfo) {
            Button("OK") {
            }
        } message: {
            Text(confoMsg)
        }
    }
    
    
    func placeOrder () async {
        //Encode the data
        guard let encoded = try? JSONEncoder().encode(order) else
        {
            print("Failed to encode order")
            return
        }
        
        
        //Request the server to save the data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        
        do{
            //Fetch the data from server
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //Decode the data from server
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            
            confoMsg = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type]) cupcakes is on its way!"
            showConfo = true
            
        } catch {
            print("Checkout Failed \(error.localizedDescription)")
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
