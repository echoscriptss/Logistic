//
//  QuestionnaireBoolView.swift
//  Despir
//
//  Created by Prabhjot Singh on 14/01/26.
//

import SwiftUI

struct QuestionnaireBoolView: View {
  @State var isMadatory: Bool = true
  @State private var selectedIndex: Int? = nil
  let titles = ["YES", "NO"]
  var body: some View {
    
    HStack {
      Spacer().frame(width: 15)
      VStack(alignment: .leading) {
        HStack {
          Text("Update provided to customer?")
          Spacer().frame(width: 0)
          if isMadatory {
            Text("*")
          }
          Spacer()
        }
        HStack(spacing: 12) {
          ForEach(titles.indices, id: \.self) { index in
            Button {
              selectedIndex = index
            } label: {
              Text(titles[index])
                .frame(width: 70, height: 50)
                .foregroundColor(selectedIndex == index ? .blue : .gray)
                .overlay(
                  RoundedRectangle(cornerRadius: 0)
                    .stroke(selectedIndex == index ? Color.blue : Color.gray, lineWidth: 1)
                )
                //.cornerRadius(8)
            }
          }
        }
       
      }
    }
  }
}

#Preview {
    QuestionnaireBoolView()
}
