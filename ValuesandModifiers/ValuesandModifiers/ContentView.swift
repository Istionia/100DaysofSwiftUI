//
//  ContentView.swift
//  ValuesandModifiers
//
//  Created by Timothy on 11/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false
    
    var body: some View {
        Button("That's rough, buddy") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(.yellow)
        
        Text("Hello, world!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
        
        Button("Boo-Boo!") {
                    // flip the Boolean between true and false
                    useRedText.toggle()
                }
                .foregroundColor(useRedText ? .red : .blue)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
