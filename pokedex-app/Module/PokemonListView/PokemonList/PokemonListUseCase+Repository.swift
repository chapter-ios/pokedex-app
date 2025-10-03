//
//  PokemonListUseCase+Repository.swift
//  pokedex-app
//
//  Created by PhinCon on 11/09/25.
//

import Foundation
import GeneralApiServices

protocol PerformFetchPokemontRepo: AnyObject {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListModel
    func fetchPokemonDetail(id: Int) async throws -> PokemonCardListModel
}

protocol PerformUseCasePokemon {
    func execute(limit: Int, offset: Int) async throws -> PokemonListModel
}

//Repository = data source abstraction
class FetchPokemonRepo: PerformFetchPokemontRepo {
    
    let api = ApiClient()
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListModel {
        let data = try await api.getRequests(type: PokemonListModel.self, url: Endpoint.pokemonList(limit: limit, offSet: offset).urlString)
        return data
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonCardListModel {
        let url = Endpoint.pokemonDetail(id: id).urlString
        let data = try await api.getRequests(type: PokemonCardListModel.self, url: url)
        return data
    }
    
}

//Use Case ->  business logic
class DefaultPokemonUseListCase: PerformUseCasePokemon {
    
    private let repo: PerformFetchPokemontRepo
    private let network: NetworkChecking
    
    init(
        with repo: PerformFetchPokemontRepo,
        network: NetworkChecking
    ) {
        self.repo = repo
        self.network = network
    }
    
    func execute(
        limit: Int,
        offset: Int
    ) async throws -> PokemonListModel {
        guard network.isConnected else {
            throw HandlePokemonDomainError.networkError
        }
        do {
            let data = try await repo.fetchPokemonList(limit: limit, offset: offset)
            return data
        } catch let error as APIErrorState {
            throw self.mapDomainError(error)
        } catch {
            throw HandlePokemonDomainError.unknown
        }
    }
    
    private func mapDomainError(_ apiState: APIErrorState) -> HandlePokemonDomainError {
        switch apiState {
        case .invalidUrl: return .invalidUrl
        case .responseError(let statusCode):
            switch statusCode {
            case 400: return .badRequest
            case 404: return .notFound
            case 500: return .serverError
            default:  return .unknown
            }
        case .decodingError(_): return .decodingError
        case .networkError(_): return .networkError
        }
    }
}

