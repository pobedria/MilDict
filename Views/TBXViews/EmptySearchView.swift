//
//  EmptySearchView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 17.05.2024.
//

import SwiftUI

struct EmptySearchView: View {
    var body: some View {
        Text("Не знайдено \(Image(systemName: "exclamationmark.bubble"))")
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Olive"))
            .foregroundColor(Color("Gold"))
            .font(Font.custom("UAFSans-Medium", size: 20))
    }
}

#Preview {
    EmptySearchView()
}
