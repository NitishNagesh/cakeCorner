//
//  ContentView.swift
//  cakeCorner
//
//  Created by nitish nayak n on 05/09/20.
//  Copyright © 2020 nitish nayak n. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var Order = order()
    var body: some View {
        NavigationView{
            
            
            Form{
                Section{
                
            
            
                    Picker("select the types", selection:$Order.type){
                        ForEach(0..<order.types.count, id: \.self){
                    Text(order.types[$0])
                        .fontWeight(.bold)
                }
            
            }
                    
                    Stepper(value:$Order.quantity, in: 3...20){
                        Text("number of cakes \(Order.quantity)")
                    }
                        
                    }
                
                Section{
                    Toggle("need special touch", isOn:$Order.specialRequestEnabled.animation())
                    
                    if Order.specialRequestEnabled{
                        
                        Toggle(isOn:$Order.froastingEnabled){
                            Text("froasting needed")
                        }
                        
                        Toggle(isOn: $Order.sprinklerEnabled){
                            Text("sprinklet needed")
                        }
                    
                    
                }
                }
                
                
                Section{
                    NavigationLink(destination:AddressView(Order: Order)){
                        Text("delivery details")
                    }
                }
            
                
            }.navigationBarTitle("cake corner",displayMode: .inline)
            
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
