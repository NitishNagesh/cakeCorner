//
//  order.swift
//  cakeCorner
//
//  Created by nitish nayak n on 05/09/20.
//  Copyright © 2020 nitish nayak n. All rights reserved.
//

import SwiftUI

class order : ObservableObject, Codable{
    
    
    enum CodingKeys:CodingKey{
        case type, city, streetAddress,quantity,specialRequestEnabled,froastingEnabled,sprinklerEnabled,name,zip
    }
    
static let types = ["strawberry","venilla","mango"]
    
    @Published var type = 0
    @Published var quantity = 0
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                froastingEnabled = false
                sprinklerEnabled = false
            }
        }
    }
    @Published var froastingEnabled = false
    @Published var sprinklerEnabled = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var zip = ""
    @Published var city = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }
    
    
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if froastingEnabled {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if sprinklerEnabled {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
         try container.encode(sprinklerEnabled, forKey: .sprinklerEnabled)
         try container.encode(froastingEnabled, forKey: .froastingEnabled)
         try container.encode(city, forKey: .city)
         try container.encode(zip, forKey: .zip)
         try container.encode(streetAddress, forKey: .streetAddress)
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      type =  try container.decode(Int.self, forKey: .type)
       name =  try container.decode(String.self, forKey: .name)
        quantity = try container.decode(Int.self, forKey: .quantity)
        specialRequestEnabled = try container.decode(Bool.self, forKey:.specialRequestEnabled)
        sprinklerEnabled = try container.decode(Bool.self, forKey: .sprinklerEnabled)
        froastingEnabled = try container.decode(Bool.self, forKey: .froastingEnabled)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        
    }
    init(){}
    
}



    
    


