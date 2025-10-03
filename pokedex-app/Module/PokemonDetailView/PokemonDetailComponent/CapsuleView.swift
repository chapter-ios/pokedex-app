//
//  CapsuleView.swift
//  pokedex-app
//
//  Created by PhinCon on 12/09/25.
//

import SwiftUI

struct CapsuleView: View {
    var body: some View {
        Text("Type")
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(.white)
            .padding(10)
            .background(Color("capsule-background-color"))
            .clipShape(.capsule)
    }
}

#Preview {
    CapsuleView()
}
