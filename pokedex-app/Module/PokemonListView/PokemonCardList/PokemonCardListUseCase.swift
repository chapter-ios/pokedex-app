//
//  PokemonCardListUseCase.swift
//  pokedex-app
//
//  Created by PhinCon on 18/09/25.
//

import Foundation
import GeneralApiServices

protocol PokemonCardListUseCase: AnyObject {
    func execute(id: Int) async throws -> PokemonCardListModel
}

class DefaultPokemonCardListUseCase: PokemonCardListUseCase {

    let repo: PerformFetchPokemontRepo
    let network: NetworkChecking
    
    init(repo: PerformFetchPokemontRepo, network: NetworkChecking) {
        self.repo = repo
        self.network = network
    }
    
    func execute(id: Int) async throws -> PokemonCardListModel {
        guard network.isConnected else {
            throw HandlePokemonDomainError.networkError
        }
        
        do {
            let data = try await repo.fetchPokemonDetail(id: id)
            return data
        } catch let error as APIErrorState {
            throw mapDomainError(apiError: error)
        }
    }
    
    private func mapDomainError(apiError: APIErrorState) -> HandlePokemonDomainError {
        switch apiError {
        case .invalidUrl:
            return .invalidUrl
        case .responseError(let statusCode):
            switch statusCode {
            case 400: return .badRequest
            case 404: return .notFound
            case 500: return .serverError
            default:  return .unknown
            }
        case .decodingError(_): return .decodingError
        case .networkError(_):return .networkError
        }
    }
}
