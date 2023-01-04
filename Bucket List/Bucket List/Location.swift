//
//  Location.swift
//  Bucket List
//
//  Created by Timothy on 05/01/2023.
//
// Protocols required:
// - Identifiable, so we can create many location markers in our map.
// - Codable, so we can load and save map data easily.
// - Equatable, so we can find one particular location in an array of locations.

// As Paul Hudson would say: "I’m a huge fan of making structs conform to Equatable as standard, even if you can’t use an optimized comparison function like above – structs are simple values like strings and integers, and I think we should extend that same status to our own custom structs too."

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // ADD AN EXAMPLE!!! This can't be overstated - it makes previewing significantly easier.
    static let example = Location(id: UUID(), name: "University of Oxford Botanic Garden", description: "I’ll be looking for you, Will, every moment, every single moment. And when we do find each other again we’ll cling together so tight that nothing and no one’ll ever tear us apart. Every atom of me and every atom of you... We’ll live in birds and flowers and dragonflies and pine trees and in clouds and in those little specks of light you see floating in sunbeams... And when they use our atoms to make new lives, they won’t just be able to take one, they’ll have to take two, one of you and one of me, we’ll be joined so tight...", latitude: 51.7510, longitude: 1.2477)
    
    // add a custom == function to the struct!
    // behind the scenes, Swift will write this function for us by comparing every property against every other property, which is rather wasteful – all our locations already have a unique identifier, so if two locations have the same identifier then we can be sure they are the same without also checking the other properties.
    // save a bunch of work - write our own == function to Location, which compares two identifiers and nothing else:
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
