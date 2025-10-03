//
//  PokemonListViewModel.swift
//  pokedex-app
//
//  Created by PhinCon on 16/09/25.
//

import Foundation
import GeneralApiServices

enum UIState<T> {
    case idle
    case loadingData
    case didSuccessFetchData(T)
    case didFailed(error: HandlePokemonDomainError)
}

@MainActor
class DefaultPokemonListViewModel: ObservableObject {
    private let listUseCase: PerformUseCasePokemon
    private let cardUsecase: PokemonCardListUseCase
    
    private var offset: Int = 0
    
    @Published var listState: UIState<PokemonListModel> = .idle
    @Published var cardListModel: [PokemonCardListModel] = []
    
    init(listUseCase: PerformUseCasePokemon, cardUsecase: PokemonCardListUseCase) {
        self.listUseCase = listUseCase
        self.cardUsecase = cardUsecase
    }
    
    func loadMenus(limit: Int) async {
        
        self.listState = .loadingData
        do {
            let data = try await listUseCase.execute(limit: limit, offset: offset)
            let details: [PokemonCardListModel] = await withTaskGroup(
                of: PokemonCardListModel.self,
                returning: [PokemonCardListModel].self
            ) {[weak self] group in
                guard let self else { return [] }
                
                for (_, pokemon) in data.results.enumerated() {
                    group.addTask {
                        do {
                            let trimmed = pokemon.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                            if let _id = trimmed.split(separator: "/").last, let id = Int(_id) {
                                return try await self.cardUsecase.execute(id: id)
                            } else {
                                return PokemonCardListModel.failed(id: 1)
                            }
                        } catch {
                            let trimmed = pokemon.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                                      let id = Int(trimmed.split(separator: "/").last ?? "0") ?? 0
                            return PokemonCardListModel.failed(id: id)
                        }
                     
                    }
                }
                
                var results: [PokemonCardListModel] = []
                for await result in group {
                    results.append(result)
                }
                return results.sorted { $0.id < $1.id }
            }
            self.listState = .didSuccessFetchData(data)
            self.cardListModel = details
        } catch let error as HandlePokemonDomainError {
            self.listState = .didFailed(error: error)
        } catch {
            self.listState = .didFailed(error: .unknown)
        }
    }
}

@MainActor
final class PokemonListViewModelFactory {
    func makePokemonListViewModel() -> DefaultPokemonListViewModel {
        let repo = FetchPokemonRepo()
        let useCase = DefaultPokemonUseListCase(with: repo, network: NetworkMonitor())
        let cardUseCase = DefaultPokemonCardListUseCase(repo: repo, network: NetworkMonitor())
        let vm = DefaultPokemonListViewModel(
            listUseCase: useCase,
            cardUsecase: cardUseCase
        )
        return vm
    }
}
