//
//  PokemonTableViewCell.swift
//  Gokemon
//
//  Created by Ihwan ID on 03/02/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType1: UIImageView!
    @IBOutlet weak var pokemonType2: UIImageView!
    @IBOutlet weak var pokemonId: UILabel!

    func configure(pokemon: Pokemon){
        pokemonName.text = pokemon.name.capitalizingFirstLetter()
        let url = URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokemon.id).png")!
      pokemonImage.kf.setImage(with: url)
        pokemonType1.image = UIImage(named: pokemon.type.first?.capitalized ?? "")

        pokemonId.text = "#\(String(format: "%03d", pokemon.id))"

        if pokemon.type.count > 1{
            pokemonType2.image = UIImage(named: pokemon.type[1].capitalized)
        }
    }

    override func prepareForReuse() {
        self.pokemonImage.image = nil;
    }

}
