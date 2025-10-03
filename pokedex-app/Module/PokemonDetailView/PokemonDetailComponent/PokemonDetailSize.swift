//
//  PokemonDetailSize.swift
//  pokedex-app
//
//  Created by PhinCon on 12/09/25.
//

import SwiftUI


struct PokemonDetailSizeBuilder: View {
    var imageIcon: String
    var generalText: String
    var abilities: [String] = []
    var subtitleText: String
    
    var body: some View {
        HStack {
            PokemonDetailSize(
                imageIcon: "weight-asset",
                generalText: "9,9 Kg",
                abilities: [
                    "Makan", "Minum"
                ],
                subtitleText: "Weight"
            )
            
            PokemonDetailSize(
                imageIcon: "weight-asset",
                generalText: "9,9 Kg",
                abilities: [
                    "Makan", "Minum"
                ],
                subtitleText: "Weight"
            )
            
            PokemonDetailSize(
                imageIcon: "weight-asset",
                generalText: "9,9 Kg",
                abilities: [
                    "Makan", "Minum"
                ],
                subtitleText: "Weight"
            )
        }
    }
}


struct PokemonDetailSize: View {
    var imageIcon: String
    var generalText: String
    var abilities: [String] = []
    var subtitleText: String
    private var didHideIcon: Bool {
        !abilities.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                if didHideIcon == false {
                    Image(imageIcon)
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                        .frame(width: 20)
                }
                if abilities.isEmpty == false {
                    VStack {
                        ForEach(abilities, id: \.self) { abiliy in
                            Text(abiliy)
                        }
                    }
                } else {
                    Text(generalText)
                }
                
            }
            Spacer()
                .frame(height: 20)
            Text(subtitleText)
        }
    }
}

#Preview {
    PokemonDetailSizeBuilder(
        imageIcon: "weight-asset",
        generalText: "9,9 Kg",
        abilities: [
            "Makan", "Minum"
        ],
        subtitleText: "Weight"
    )
}
