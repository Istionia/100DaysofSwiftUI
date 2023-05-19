//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Timothy on 02/11/2022.
//

import SwiftUI

struct AddressView: View {
    //@ObservedObject var order = Order()
    @ObservedObject var currentOrder = currentOrders()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $currentOrder.order.name)
                TextField("Street address", text: $currentOrder.order.streetAddress)
                TextField("City", text: $currentOrder.order.city)
                TextField("Zip code", text: $currentOrder.order.zip)
            }
            
            Section {
                NavigationLink("Checkout", destination: CheckoutView(currentOrder: currentOrder))
            }
            .disabled(currentOrder.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(currentOrder: currentOrders())
        }
    }
}
