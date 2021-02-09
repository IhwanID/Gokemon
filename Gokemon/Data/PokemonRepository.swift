//
//  PokemonRepository.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation
import Combine

protocol PokemonRepositoryProtocol {
    func getPokemons() -> AnyPublisher<[Pokemon], Error>
}

final class PokemonRepository{
    typealias PokemonInstance = (LocalDataSource, RemoteDataSource) -> PokemonRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocalDataSource

    private init(local: LocalDataSource,remote: RemoteDataSource) {
        self.locale = local
        self.remote = remote
    }

    static let shared = { localRepo, remoteRepo in
        return PokemonRepository(local: localRepo,remote: remoteRepo)
    }
}

extension PokemonRepository: PokemonRepositoryProtocol{
    func getPokemons() -> AnyPublisher<[Pokemon], Error> {

        return self.locale.getPokemons()
            .flatMap { result -> AnyPublisher<[Pokemon], Error> in
                if result.isEmpty {
                    return self.remote.getPokemonListWithDetails()
                        .map {
                            PokemonMapper.mapPokemonResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addPokemons(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPokemons()
                            .map { PokemonMapper.mapPokemonEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getPokemons()
                        .map { PokemonMapper.mapPokemonEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()

    }

}
