//
//  ConstantHelper.swift
//  pokedex-app
//
//  Created by PhinCon on 15/09/25.
//

import Foundation

struct ApiConfig {
    static let baseUrl = "https://pokeapi.co/api/v2"
    static let pokemonUrl = "/pokemon"
}

enum Endpoint {
    case pokemonList(limit: Int, offSet: Int)
    case pokemonDetail(id: Int)
    
    var url: URL? {
        var components = URLComponents(string: ApiConfig.baseUrl)
        
        switch self {
        case .pokemonList(let limit, let offset):
            components?.path = ApiConfig.pokemonUrl.lowercased()
            components?.queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
            components?.queryItems = [URLQueryItem(name: "offset", value: "\(offset)")]
        case .pokemonDetail(let id):
            components?.path = "\(ApiConfig.pokemonUrl)\(id)"
        }
        return components?.url
    }
    
    var urlString: String {
        switch self {
        case .pokemonList(let limit, let offset):
            return "\(ApiConfig.baseUrl)/pokemon?limit=\(limit)&offset=\(offset)"
        case .pokemonDetail(let id):
            return "\(ApiConfig.baseUrl)/pokemon/\(id)/"
        }
    }
}
