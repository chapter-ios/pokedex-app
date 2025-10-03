//
//  PokemonDetailView.swift
//  pokedex-app
//
//  Created by PhinCon on 12/09/25.
//

import SwiftUI

struct PokemonDetailView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color("detail-background-color")
                .ignoresSafeArea()
            //Pokeball background + bulbasaur dummy image
            PokeballBackgroundView()
                .offset(y: -70)
            //Add DetailComponent here, dont forget to add offset
            ScrollView {
                VStack {
                    
                }.background(.white)
            }
            VStack {
                Text("asd")
            }
            .frame(minWidth: 300, minHeight: 100)
            .background(.white)
            .offset(y: 150)
            
            
            
            Image("pokemon-dummy")
                .resizable()
                .frame(width: 200, height: 200)
                .offset(y: 0)
        }
    }
}

struct PokeballBackgroundView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("pokeball-asset")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(Color.white.opacity(0.1))
                .padding()
            
        }
//        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    PokemonDetailView()
}
