//
//  ViewController.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import UIKit
import Kingfisher

class HomeTableViewController: UITableViewController {

    var homePresenter: HomePresenter?
    let activityView = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        self.tableView.backgroundView = activityView
        activityView.startAnimating()
        

        self.homePresenter = HomePresenter(homeUseCase: Injection.init().provideHomeUseCase())
        self.homePresenter?.getPokemons()

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)

            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.backgroundView = nil
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetail"){
            guard let data = sender as? Pokemon else { return }
            let vc = segue.destination as! DetailViewController
            vc.pokemon = data
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender:  self.homePresenter?.pokemons[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homePresenter?.pokemons.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        let pokemon = self.homePresenter!.pokemons[indexPath.row]
        cell.configure(pokemon: pokemon)
        return cell
    }
}
