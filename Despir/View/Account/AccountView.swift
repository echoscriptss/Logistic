//
//  AccountView.swift
//  Despir
//
//  Created by Prabhjot Singh on 27/01/26.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
      VStack {
        CustomNavigationBar(title: "Account", showBack: false, showLogo: true)
        Spacer()
      }
    }
}

#Preview {
    AccountView()
}
