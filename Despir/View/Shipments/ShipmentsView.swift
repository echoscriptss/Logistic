//
//  ShipmentsView.swift
//  Despir
//
//  Created by Prabhjot Singh on 27/01/26.
//

import SwiftUI

struct ShipmentsView: View {
    var body: some View {
      VStack {
        CustomNavigationBar(title: "Shipments", showBack: false, showLogo: true)
        Spacer().frame(height: 10)
        HStack {
          Spacer()
          Button(action: {
              
          }) {
            Image(AppIcons.filter)
          }
          Spacer().frame(width: 10)
        }
        Spacer()
      }
    }
}

#Preview {
    ShipmentsView()
}
