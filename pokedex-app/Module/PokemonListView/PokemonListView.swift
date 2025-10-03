//
//  PokemonListView.swift
//  pokedex-app
//
//  Created by PhinCon on 11/09/25.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @StateObject var vm: DefaultPokemonListViewModel
    
    init(vm: DefaultPokemonListViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    let dummyData = Array(repeating: "Pokemon", count: 20)
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                makeContent(for: self.vm.listState)
            }
            .padding(6)
        }.task {
            await self.vm.loadMenus(limit: 100)
        }
        .environmentObject(vm)
    }
    
    @ViewBuilder
    private func makeContent(for state: UIState<PokemonListModel>) -> some View {
        switch state {
        case .idle:
            EmptyView()
        case .loadingData:
            ProgressView("Loading your Data")
        case .didSuccessFetchData(_):
            ForEach(self.vm.cardListModel, id: \.self) { data in
                PokemonCardView(
                    details: data
                )
            
            }
        case .didFailed(_):
            EmptyView() // will use error View Later or can be with default image
        }
    }
}

struct PokemonCardView: View {
    
    let details: PokemonCardListModel
    
    @EnvironmentObject var vm: DefaultPokemonListViewModel
    @State var pokemonDetail: PokemonCardListModel?
    
    var body: some View {
        
        if self.details.isFailed == true {
            EmptyView()// create something later
        } else {
            
            VStack(alignment: .center,spacing: 4) {
                HStack {
                    Spacer()
                    OrderText(id: details.id)
                        .font(.system(size: 12))
                        .padding(.trailing, 8)
                        .padding(.top, 8)
                    
                }
                ZStack(alignment: .bottom) {
                    Color.gray.opacity(0.3)
                        .frame(height: 60)
                        
                    VStack {
//                        AsyncImage(url: details.sprites.other?.officialArtwork.frontDefaultURL) { image in
//                            image.resizable()
//                                .scaledToFit()
//                        } placeholder: {
//                            Image("pokemon-dummy")
//                        }
//                        .frame(height: 90)
//                        
                        KFImage(details.sprites.other?.officialArtwork.frontDefaultURL)
                            .placeholder {
                                Image("pokemon-dummy")
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                            .clipped()

                        Text(details.name)
                            .font(.system(size: 14))
                        Spacer()
                    }
                    
                }
                
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 8))
            .shadow(color:Color.gray.opacity(0.8), radius: 4/*,x: 0, y: 4*/)
            .padding(4)
        }
    }
}

struct OrderText: View {
    let id: Int
    private var placeHolder: String {
        if id < 10  {
            return "00"
        } else if id < 100 {
            return "0"
        } else {
            return ""
        }
    }
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {

        Text("#\(self.placeHolder)\(self.id)")
            .foregroundStyle(Color.black)
            .font(.system(size: 12))
            .padding(.trailing, 8)
            .padding(.top, 8)
    }
}
