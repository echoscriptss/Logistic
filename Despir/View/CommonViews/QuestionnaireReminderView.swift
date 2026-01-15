//
//  QuestionnaireReminderView.swift
//  Despir
//
//  Created by Prabhjot Singh on 14/01/26.
//

import SwiftUI

struct QuestionnaireReminderView: View {
  
  @State var isMadatory: Bool = true

    var body: some View {
      HStack {
        Spacer().frame(width: 15)
        VStack(alignment: .leading) {
          HStack {
            Image("") // bell icon
            Spacer().frame(width: 5)
            Text("Remind driver of requirements at next stop")
            Spacer().frame(width: 0)
            if isMadatory {
              Text("*")
            }
            Spacer()
          }
        }
        Spacer().frame(width: 15)
      }
    }
}

#Preview {
    QuestionnaireReminderView()
}
