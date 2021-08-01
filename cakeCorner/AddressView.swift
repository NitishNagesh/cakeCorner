//
//  AddressView.swift
//  cakeCorner
//
//  Created by nitish nayak n on 05/09/20.
//  Copyright © 2020 nitish nayak n. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var Order = order()
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $Order.name)
                TextField("Street Address", text:$Order.streetAddress)
                TextField("City", text:$Order.city)
                TextField("Zip", text: $Order.zip)
            }

            Section {
                NavigationLink(destination: checkOut(Order: Order)) {
                    Text("Check out")
                }
                .disabled(Order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
