//
//  HomeView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var appRootManager: AppRootManager
  @State private var isMenuOpen = false
  
    var body: some View {

      VStack {
        Text("Home Screen")
          .font(.system(size: 36.0).bold())
        Spacer()
        Text("Long press for settings")
          .font(.system(size: 20.0).bold())
          .contextMenu {
            Button("Update Profile") {
              appRootManager.push(.profile)
            }
            Button("Change Password") {
              appRootManager.push(.changePassword)
            }
          Spacer()
          Button {
            DataManager.isUserLoggedIn = false
            appRootManager.currentRoot = .login
            
          } label: {
            Text("Logout")
            
          }
          Spacer()
        }
      
      .navigationDestination(for: Route.self) { route in
          if route == .changePassword {
              ChangePasswordView()
          } else if route == .profile {
            ProfileView()
          }
      }

    }
    
  }
}

#Preview {
    HomeView()
}
