//
//  DomainError.swift
//  pokedex-app
//
//  Created by PhinCon on 16/09/25.
//

import Foundation

public enum DomainError: Error, Equatable {
    case networkError                   // no internet
    case serverError(Int)               // any 5xx or 4xx (with status code)
    case unauthorized                   // 401
    case notFound404                    // 404
    case decodingError                 // JSON decoding failed
    case business(String)               // custom domain/business rule (e.g., “balance too low”)
    case unknown
}

enum HandlePokemonDomainError: Error, Equatable { //equeateble so u can use ==
    case badRequest       // 400
    case notFound         // 404
    case serverError      // 500
    case networkError     // e.g. no internet
    case decodingError
    case invalidUrl
    case unknown
}
