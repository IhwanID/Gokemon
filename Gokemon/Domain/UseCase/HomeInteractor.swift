//
//  HomeInteractor.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getPokemons() -> AnyPublisher<[Pokemon], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: PokemonRepositoryProtocol

  required init(repository: PokemonRepositoryProtocol) {
    self.repository = repository
  }

  func getPokemons() -> AnyPublisher<[Pokemon], Error>{
    return repository.getPokemons()  }
}
