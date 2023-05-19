//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Timothy on 29/10/2022.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var order = Order()
    @ObservedObject var currentOrder = currentOrders()
    
    var body: some View {
        NavigationView {
            Form {
                // more code to come
                Section {
                    Picker("Select your cake type", selection: $currentOrder.order.type){
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(currentOrder.order.quantity)", value: $currentOrder.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $currentOrder.order.specialRequestEnabled.animation())
                    
                    if currentOrder.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $currentOrder.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $currentOrder.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink<Text, AddressView> {
                        AddressView(currentOrder: currentOrder)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
