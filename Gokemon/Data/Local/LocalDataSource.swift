//
//  LocalDataSource.swift
//  Gokemon
//
//  Created by Ihwan ID on 03/02/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: class {
    func getPokemons() -> AnyPublisher<[PokemonEntity], Error>
    func addPokemons(from pokemons: [PokemonEntity]) -> AnyPublisher<Bool, Error>
}

final class LocalDataSource: NSObject {

    private let realm: Realm?

    private init(realm: Realm?) {
        self.realm = realm
    }

    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }

}

extension LocalDataSource: LocalDataSourceProtocol {
    func getPokemons() -> AnyPublisher<[PokemonEntity], Error> {
        return Future<[PokemonEntity], Error> { completion in
            if let realm = self.realm {
                let pokemons: Results<PokemonEntity> = {
                    realm.objects(PokemonEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(pokemons.toArray(ofType: PokemonEntity.self)))
            }
        }.eraseToAnyPublisher()
    }

    func addPokemons(from pokemons: [PokemonEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                    if let realm = self.realm {
                        do {
                            try realm.write {
                                for pokemon in pokemons {
                                    realm.add(pokemon, update: .all)
                                }
                                completion(.success(true))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } 
                }.eraseToAnyPublisher()
    }


}

extension Results {

    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }

}
