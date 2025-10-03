import Foundation

struct PokemonCardListModel: Codable, Hashable {
    let id: Int
    let name: String
    let sprites: Sprites
    let species: Species
    var isFailed: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, name, species
        case sprites = "sprites"
    }

    static func failed(id: Int) -> PokemonCardListModel {
        PokemonCardListModel(
            id: id,
            name: "Unknown",
            sprites: Sprites(
                other: Other(
                    officialArtwork: OfficialArtwork(
                        frontDefault: "",
                        frontShiny: ""
                    )
                )
            ),
            species: Species(name: "", url: ""),
            isFailed: true
        )
    }
}

struct Sprites: Codable, Hashable {
    
    let other: Other?

}

struct Other: Codable, Hashable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable, Hashable {
    let frontDefault: String?
    let frontShiny: String?
    
    var frontDefaultURL: URL? {
        guard let frontDefault, let url = URL(string: frontDefault) else {
            return nil
        }
        return url
    }

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct Species: Codable, Hashable {
    let name: String
    let url: String
}
