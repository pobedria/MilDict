//
//  AppHeader.swift
//  MilDict
//
//  Created by Viktor Pobedria on 27.05.2024.
//

import SwiftUI

struct AppHeader: View {
    var body: some View {
        HStack{
            
            Image("VIKNU")
                .resizable()
                .frame(width: 40.0, height: 40.0)

            Text("MilDict")
                .font(Font.custom("UAFSans-Regular", size: 25))
                .foregroundColor(.white)
            Spacer()
            Image("LRDD")
                .resizable()
                .frame(width: 80.0, height: 40.0)
        }.padding(.horizontal)
    }
}

#Preview {
    AppHeader()
}
