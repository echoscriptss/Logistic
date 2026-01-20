//
//  AsyncActionButton.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//
import SwiftUI

struct AsyncActionButton<Label: View>: View {
    let action: () async -> Void
    let label: () -> Label


    var body: some View {
      HStack {
        Spacer().frame(width: 20)
        Button {
          Task {
            await action()
          }
        } label: {
          HStack {
            Spacer()
            label()
              .foregroundColor(.white)
            Spacer()
          }
        }  .frame(height: 50)
          .background(Color.black.opacity(0.6))
          .cornerRadius(8)
        Spacer().frame(width: 20)
      }
    
        
    }
}
