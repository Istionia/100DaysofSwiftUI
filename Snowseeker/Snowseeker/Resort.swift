//
//  Resort.swift
//  Snowseeker
//
//  Created by Timothy on 14/04/2023.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.id < rhs.id
    }
}

