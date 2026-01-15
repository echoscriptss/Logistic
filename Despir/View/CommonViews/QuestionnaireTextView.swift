//
//  QuestionnaireTextView.swift
//  Despir
//
//  Created by Prabhjot Singh on 14/01/26.
//

import SwiftUI

struct QuestionnaireTextView: View {
  
  @State var answer: String = "27.7"
  @State var isMadatory: Bool = true
  
  var body: some View {
    HStack {
      Spacer().frame(width: 15)
      VStack(alignment: .leading) {
        HStack {
          Text("What is Trailer's Current Temperature")
          Spacer().frame(width: 0)
          if isMadatory {
            Text("*")
          }
        }
        HStack {
          Spacer().frame(width: 5)
          TextField("", text: $answer)
            .frame(height: 50)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
          Spacer().frame(width: 5)
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
      }
      Spacer().frame(width: 15)
    }
  }
}

#Preview {
    QuestionnaireTextView()
}
