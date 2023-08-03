//
//  TermView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct TermView: View {
    
    var term: Term
    var body: some View {
        VStack(alignment: .leading) {
            HStack( alignment: .top){
                Text(term.en_title)
                    .font(.body)
                    .foregroundColor(Color("Primary"))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                if term.ua_title.isEmpty{
                    Text("⚠️ Переклад не стандартизовано")
                        .font(.body)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }else {
                    Text(term.ua_title)
                        .font(.body)
                        .foregroundColor(Color("Secondary"))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
        }
    }
}

struct TermView_Previews: PreviewProvider {
    static var previews: some View {
        TermView(term:
            Term(
                id: 1,
                en_title: "LOCAL AREA NETWORK",
                en_text: "A collection of items that aid connectivity for computers that are connected to the network.  Aids in connecting to remote computer and in send and receive data.  May include personnel computer, router, hub and server not inclusively.",
                ua_title: "МЕРЕЖА ЛОКАЛЬНА",
                ua_text: "Група виробів, які забезпечують можливість мережевої взаємодії під'єднаних до мережі комп'ютерів.  Забезпечує можливість взаємодії з віддаленим комп'ютером, а також відправлення та отримання даних.  Може включати персональний комп'ютер, маршрутизатор, концентратор і сервер (не обов'язково)."
            )
        )
    }
}
