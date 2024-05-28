//
//  AppHeader.swift
//  MilDict
//
//  Created by Viktor Pobedria on 27.05.2024.
//

import SwiftUI

struct AppHeader: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color("Olive"))
                .frame(width: UIScreen.main.bounds.width, height: 60)
                .shadow( radius: 2,  x: 0, y:3)
            HStack{
                
                Image("VIKNU")
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                
                Text("MilDict")
                    .font(Font.custom("Volja-Regular", size: 20))
                    .foregroundColor(Color("Steppe"))
                Spacer()
                Image("LRDD")
                    .resizable()
                    .frame(width: 80.0, height: 40.0)
            }.padding(.horizontal)
        }
    }
}

#Preview {
    AppHeader()
}
