//
//  TermTextView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 09.07.2024.
//

import SwiftUI
import AVFoundation

struct TermTextView: View {
    var term: AppTerm
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        HStack{
            Text( term.term)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(.gold)
                .font(Font.custom("UAFSans-Medium", size: 25))
            Button("", systemImage: "airpodsmax", action: {
                let utterance = AVSpeechUtterance(string: term.term)
                if term.lang == "en"{
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    utterance.rate = 0.5
                } else {
                    utterance.voice = AVSpeechSynthesisVoice(language: "uk-UA")
                    utterance.rate = 0.5
                }
                
                synthesizer.speak(utterance)
            })
        }
    }
}

#Preview {
    let term = AppTerm(id: 2, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "psychological operation", description: "Planned activities using methods of communication and other means directed at approved audiences in order to influence perceptions, attitudes and behaviour, affecting the achievement of political and military objectives.", xref: "https://github.com/pobedria/mildictmeta/blob/main/AAP-06.pdf")
    return TermTextView(term: term)
}
