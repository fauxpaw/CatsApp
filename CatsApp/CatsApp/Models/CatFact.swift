//
//  CatFact.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/17/22.
//

import Foundation

/// network root object for the CatFacts
struct FactsCollection: Codable {
    let data: [CatFact]
}

struct CatFact: Codable {
    let fact: String
}
