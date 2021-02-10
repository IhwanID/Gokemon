//
//  HomePresenter.swift
//  Gokemon
//
//  Created by Ihwan ID on 02/02/21.
//

import Foundation
import Combine

class HomePresenter{

    private var cancellables: Set<AnyCancellable> = []
    private let homeUseCase: HomeUseCase

    var pokemons: [Pokemon] = []
    var errorMessage = ""
    var loadingState = true

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getPokemons(){
        self.homeUseCase.getPokemons().receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = "failure"
            case .finished:
                break
            }
        }, receiveValue: { pokemons in
            self.pokemons = pokemons.sorted(by: { $0.id < $1.id })

        })
        .store(in: &cancellables)

    }
}
