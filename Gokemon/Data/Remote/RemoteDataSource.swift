//
//  RemoteDataSource.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol: class {
    func getPokemon (_ urlString: String) -> AnyPublisher<PokemonDetailResponse, Error>
    func getPokemonList (urlString: String) ->  AnyPublisher<PokemonListResponse, Error>
    func getPokemonListWithDetails () -> AnyPublisher<[PokemonDetailResponse], Error>
}

final class RemoteDataSource: NSObject {

    private override init() { }

    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {


    func getPokemon (_ urlString: String) -> AnyPublisher<PokemonDetailResponse, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: PokemonDetailResponse.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }


    func getPokemonList (urlString: String) ->  AnyPublisher<PokemonListResponse, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func getPokemonListWithDetails () -> AnyPublisher<[PokemonDetailResponse], Error> {
        return getPokemonList(urlString: "https://pokeapi.co/api/v2/pokemon/")
            .map(\.results)
            .flatMap(maxPublishers:.max(1)) {
                Publishers
                    .MergeMany($0.map { self.getPokemon($0.url) })
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}
