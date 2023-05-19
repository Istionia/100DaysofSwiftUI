//
//  CurrentOrders.swift
//  CupcakeCorner
//
//  Created by Timothy on 04/11/2022.
//

import SwiftUI

class currentOrders: ObservableObject {
  @Published var order: Order
   
  init() {
    order = Order(type: 0, quantity: 3, extraFrosting: false, addSprinkles: false, name: "", streetAddress: "", city: "", zip: "", specialRequestEnabled: false, hasValidAddress: false)
  }
}
