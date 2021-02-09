//
//  PokemonResponse.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation

struct PokemonResponse: Codable{
    let name: String
    let url: String
}

struct PokemonListResponse: Codable{
    let results: [PokemonResponse]
}

struct PokemonDetailResponse: Codable{
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [Types]
}

struct Types: Codable{
    let slot: Int
    let type: Type
}

struct Type: Codable{
    let name: String
}
