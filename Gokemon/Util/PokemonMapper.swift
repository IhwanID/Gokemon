//
//  PokemonMapper.swift
//  Gokemon
//
//  Created by Ihwan ID on 03/02/21.
//

import Foundation

final class PokemonMapper {

    static func mapPokemonResponsesToEntities(
        input PokemonResponses: [PokemonDetailResponse]
    ) -> [PokemonEntity] {
        return PokemonResponses.map { result in
            let pokemon = PokemonEntity()
            pokemon.id = result.id
            pokemon.name = result.name
            pokemon.type.append(objectsIn: result.types.map{$0.type.name})

            //=

            return pokemon
        }
    }

    static func mapPokemonEntitiesToDomains(
        input PokemonEntities: [PokemonEntity]
    ) -> [Pokemon] {
        return PokemonEntities.map { result in

            return Pokemon(id: result.id, name: result.name, type: result.type.map{$0})
        }
    }

    static func mapPokemonResponsesToDomains(
        input PokemonResponses: [PokemonDetailResponse]
    ) -> [Pokemon] {

        return PokemonResponses.map { result in
            return Pokemon(id: result.id, name: result.name, type: result.types.map{$0.type.name})
        }
    }

}
