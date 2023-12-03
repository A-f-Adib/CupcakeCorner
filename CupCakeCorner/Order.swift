//
//  Order.swift
//  CupCakeCorner
//
//  Created by A.f. Adib on 11/22/23.
//

import SwiftUI

class Order : ObservableObject , Codable {
    
    
    enum CodingKeys : CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAdd, city, zip
    }
    
    
    
   static let types = [ "Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
   @Published var type = 0
    
    @Published var quantity = 3
    
    @Published var specialRequestEnb = false {
        
        didSet {
            if specialRequestEnb == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAdd = ""
    @Published var city = ""
    @Published var zip = ""
    
    
     var hasValidity : Bool {
        if name.isEmpty || streetAdd.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        //costly cakes
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
            
        }
        
        //$0.5/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
        
    }
    
    init() {
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAdd, forKey: .streetAdd)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAdd = try container.decode(String.self, forKey: .streetAdd)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
}
