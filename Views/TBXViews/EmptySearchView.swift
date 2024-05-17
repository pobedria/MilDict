//
//  EmptySearchView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 17.05.2024.
//

import SwiftUI

struct EmptySearchView: View {
    var body: some View {
        Text("Не знайдено")
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Olive"))
            .foregroundColor(.red)
    }
}

#Preview {
    EmptySearchView()
}
