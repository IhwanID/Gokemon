//
//  ViewController.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var homePresenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        

        self.homePresenter = HomePresenter(homeUseCase: Injection.init().provideHomeUseCase())
        self.homePresenter?.getPokemons()

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homePresenter?.pokemons.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        let pokemon = self.homePresenter?.pokemons[indexPath.row]
        cell.pokemonName.text = pokemon?.name
        let url = URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokemon!.id).png")!
        cell.pokemonImage.downloaded(from: url)

        cell.pokemonType1.image = UIImage(named: pokemon?.type.first?.capitalized ?? "")
        
        if (pokemon?.type.count)! > 1{
            cell.pokemonType2.image = UIImage(named: pokemon?.type[1].capitalized ?? "")
        }

        return cell
    }


    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
