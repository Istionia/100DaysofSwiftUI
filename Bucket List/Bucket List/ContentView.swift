//
//  ContentView.swift
//  Bucket List
//
//  Created by Timothy on 01/01/2023.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var locations = [Location]()
    
    @State private var selectedPlace: Location?
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                // Add a button in the bottom-right that lets us add place marks to the map. We’re already inside a ZStack, so the easiest way to align this button is to place it inside a VStack and a HStack with spacers before it each time. Both those spacers end up occupying the full vertical and horizontal space that’s left over, making whatever comes at the end sit comfortably in the bottom-right corner.
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // create a new place mark
                            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        } label: {
                            Image(systemName: "plus")
                        }
                        // make sure the button is bigger before we add a background color
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        //  push the button away from the trailing edge
                        .padding(.trailing)
                    }
                }
            }
            .sheet(item: $selectedPlace) { place in
                EditView(location: place){ newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Yay, it's possible! Go on, use it.
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication done!
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
