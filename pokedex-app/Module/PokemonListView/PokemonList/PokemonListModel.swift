//
//  PokemonListModel.swift
//  pokedex-app
//
//  Created by PhinCon on 15/09/25.
//

import Foundation

struct PokemonListModel: Codable, Hashable {
    let count: Int
    let next: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Hashable {
    let name: String
    let url: String
}
