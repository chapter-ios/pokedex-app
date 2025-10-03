//
//  PokemonGeneralStatView.swift
//  pokedex-app
//
//  Created by PhinCon on 15/09/25.
//

import SwiftUI

struct PokemonGeneralStatView: View {
    var body: some View {
        VStack {
            HStack {
                CapsuleView()
                CapsuleView()
            }
            .padding()
            
            Text("About")
            
        }
    }
}

#Preview {
    PokemonGeneralStatView()
}
