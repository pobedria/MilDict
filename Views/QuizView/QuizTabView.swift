//
//  QuizUIView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 21.05.2024.
//

import SwiftUI

struct QuizTabView: View {

    var body: some View {
        VStack{
            HStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("Olive"))
        .font(Font.custom("UAFSans-Medium", size: 20))
    }
}

#Preview {
    QuizTabView()
}
