//
//  Pokemon.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation

struct Pokemon: Equatable, Codable{
    let id: Int
    let name: String
    let type: [String]
}
