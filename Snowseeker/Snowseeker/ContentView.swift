//
//  ContentView.swift
//  Snowseeker
//
//  Created by Timothy on 05/04/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    @State var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favourites = Favourites()
    @State private var searchtext = ""

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favourites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favourite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchtext, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // let the user sort the resorts in ContentView either using the default order, alphabetical order, or country order
                    Menu("Sort by") {
                        Button {
                            sortByDefault()
                        } label: {
                            Text("Default")
                        }
                        
                        Button {
                            // sort by alphabetical order
                            sortByAlphabetical()
                        } label: {
                            Text("Alphabetical")
                        }
                        
                        Button {
                            // sort by country order
                            sortByCountry()
                        } label: {
                            Text("Country")
                        }
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favourites)
    }
    
    var filteredResorts: [Resort] {
        if searchtext.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchtext)
            }
        }
    }
    
    func sortByDefault() {
        _ = resorts.sorted {
            $0.id < $1.id
        }
    }
    
    func sortByAlphabetical() {
        resorts = resorts.sorted {
            $0.name < $1.name
        }
    }
    
    func sortByCountry() {
        resorts = resorts.sorted {
            $0.country < $1.country
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
