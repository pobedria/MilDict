//
//  TermDetail.swift
//  MilDict
//
//  Created by Viktor Pobedria on 01.08.2023.
//

import SwiftUI

struct TermDetailView: View {
    let term: Term
    var body: some View {
        VStack(alignment: .leading){
            Text(term.en_title)
                .font(.title).foregroundColor(Color("Gold"))
            
            Text(term.en_text)
                .font(.title3).foregroundColor(Color("LightKhaki"))
            Divider()
            Text(term.ua_title)
                .font(.title).foregroundColor(Color("Salad"))
            Text(term.ua_text)
                .font(.title3).foregroundColor(Color("LightKhaki"))
            Spacer()
        }
        .padding()
        .background(Color("Olive"))
    }
}

struct TermDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TermDetailView(term:
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
