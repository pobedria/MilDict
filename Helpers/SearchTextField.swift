//
//  SearchTextField.swift
//  MilDict
//
//  Created by Viktor Pobedria on 03.08.2023.
//

import SwiftUI

struct MyTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(focused ? .accentColor : Color.gray, lineWidth: 3)
        ).padding(.horizontal,10)
    }
}
