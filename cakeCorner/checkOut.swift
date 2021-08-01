//
//  checkOut.swift
//  cakeCorner
//
//  Created by nitish nayak n on 05/09/20.
//  Copyright © 2020 nitish nayak n. All rights reserved.
//

import SwiftUI

struct checkOut: View {
    @ObservedObject var Order = order()
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.Order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                    
                }
            }
        }
            
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        .navigationBarTitle("Check out", displayMode: .inline)
}




func placeOrder() {
    guard let encoded = try? JSONEncoder().encode(Order) else {
        print("Failed to encode order")
        return
    }

    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
            return
        }

        if let decodedOrder = try? JSONDecoder().decode(order.self, from: data) {
            self.confirmationMessage = "Your order for \(decodedOrder.quantity) \(order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            self.showingConfirmation = true
        } else {
            print("Invalid response from server")
        }
    }.resume()
}
}
    


struct checkOut_Previews: PreviewProvider {
    static var previews: some View {
        checkOut()
    }
}
