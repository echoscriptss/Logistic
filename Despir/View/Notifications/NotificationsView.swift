//
//  NotificationsView.swift
//  Despir
//
//  Created by Prabhjot Singh on 27/01/26.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
      VStack {
        CustomNavigationBar(title: "Notifications", showBack: false, showLogo: true)
        VStack {
          Spacer()
        }
        Spacer()
      }
    }
}

#Preview {
    NotificationsView()
}
