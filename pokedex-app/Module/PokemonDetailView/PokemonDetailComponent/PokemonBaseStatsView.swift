//
//  PokemonBaseStatsView.swift
//  pokedex-app
//
//  Created by PhinCon on 12/09/25.
//

import SwiftUI

struct PokemonBaseStatsView: View {
    
    let textColor: Color
    let value: Int
    
    var body: some View {
        HStack(spacing: 8) {
            Text("HP")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(textColor)
                .padding(.leading)
            Rectangle()
                .frame(width: 1, height: UIFont.systemFont(ofSize: 16).lineHeight)
                
            Text("999")
            
            PokemonProgressStat(
                value: value,
                color: textColor
            )
            
        }
    }
}

struct PokemonProgressStat: View {
    
    let value: Int
    let maxValue = 100
    let color: Color
    private let progressBarHeight: CGFloat = 10
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.2))
                    .frame(height: progressBarHeight)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                    .frame(width: progressWidth(totalWidth: geo.size.width), height: progressBarHeight)
                
            }
        }
        .frame(height: progressBarHeight)
        .padding(8)
    }
    
    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        let progress = CGFloat(value) / CGFloat(maxValue)
        return totalWidth * min(progress, 1)
    }
}

#Preview {
    PokemonBaseStatsView(
        textColor: Color.blue,
        value: 45)
    PokemonBaseStatsView(
        textColor: Color.blue,
        value: 45)
    PokemonBaseStatsView(
        textColor: Color.blue,
        value: 45)
}
