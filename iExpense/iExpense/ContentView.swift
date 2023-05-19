//
//  ContentView.swift
//  iExpense
//
//  Created by Timothy on 04/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let currencyFormatter = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: currencyFormatter)
                            .foregroundColor(item.amount >= 100 ? .red : item.amount >= 10 ? .indigo : .black)
                            .font(item.amount >= 100 ? .headline : .body)
                    }
                    }
                    .onDelete(perform: removeItems)
                    .accessibilityLabel("\(item.name), \(item.amount)")
                    .accessibilityHint("Name and value of expense")
            }
        }
        .navigationTitle("iExpense")
        .toolbar {
            Button {
                showingAddExpense = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
