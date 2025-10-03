//
//  PokemonNestView.swift
//  pokedex-app
//
//  Created by PhinCon on 11/09/25.
//

import SwiftUI

struct PokemonNestView: View {
    @State var text = ""
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                PokemonNestUpperView(text: $text)
            }
        }
    }
}

struct PokemonNestUpperView: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PokemonTextFieldSearch(text: $text)
                .padding(.bottom, 16)
            
            PokemonListView(vm: PokemonListViewModelFactory().makePokemonListViewModel())
                .background(.white)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.horizontal, 12)
                .padding(.bottom, -16)
        }
    }
}

struct PokemonTextFieldSearch: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image("search-icon")
                    .resizable()
                    .frame(width: 16, height: 16)
                TextField("Search", text: $text)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(.white)
            .clipShape(.rect(cornerRadius: 24))
            .shadow(color: .white, radius: 1)
            .padding(.leading, 8)
            Spacer(minLength: 16)
            
            Button(action: {
                
            }, label: {
                Image("sort-icon")
                    .padding(10)
                    .background(.white)
                    .clipShape(.circle)
            })
            .padding(.trailing, 8)
        }
    }
}

#Preview {
    PokemonNestView()
}
