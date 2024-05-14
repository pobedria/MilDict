//
//  SearchTextField.swift
//  MilDict
//
//  Created by Viktor Pobedria on 03.08.2023.
//

import SwiftUI

struct MDTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(10)
        .font(Font.custom("UAFSans-Regular", size: 16))
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color("Steppe"), lineWidth: 3)
        ).padding(.horizontal,10)
        
    }
}
