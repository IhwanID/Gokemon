//
//  Injection.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation
import RealmSwift

final class Injection {
  private func provideRepository() -> PokemonRepositoryProtocol {
    let realm = try? Realm()
    let remote = RemoteDataSource.sharedInstance
    let locale = LocalDataSource.sharedInstance(realm)
    return PokemonRepository.shared(locale, remote)
  }

  func provideHomeUseCase() -> HomeUseCase {
    let repository = self.provideRepository()
    return HomeInteractor(repository: repository)
  }

}
