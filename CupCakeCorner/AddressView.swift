//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by A.f. Adib on 11/22/23.
//

import SwiftUI

struct AddressView: View {
    
   @ObservedObject var order : Order
    
    var body: some View {
      
            Form {
                Section {
                    TextField("Name", text: $order.name )
                    TextField("Street Address ", text: $order.streetAdd)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section{
                    NavigationLink("Check Out") {
                        CheckOutView(order: order)
                    }
                }
                .disabled(order.hasValidity == false)
            }
        
            .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
