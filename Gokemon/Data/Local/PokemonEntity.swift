//
//  PokemonEntity.swift
//  Gokemon
//
//  Created by Ihwan ID on 03/02/21.
//

import Foundation
import RealmSwift

class PokemonEntity: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    var type = List<String>()
   

    override static func primaryKey() -> String? {
        return "id"
    }
}
