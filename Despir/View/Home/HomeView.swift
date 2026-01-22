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
  @ObservedObject var viewModel = ShipmentsViewModel()
  
    var body: some View {

      VStack {
        CustomNavigationBar(title: "SHIPMENTS", showBack: false)
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
          }
          Spacer()
          Button {
            DataManager.isUserLoggedIn = false
            appRootManager.currentRoot = .login
            
          } label: {
            Text("Logout")
            
          }
        Spacer()
          Button {
              appRootManager.currentRoot = .filterCalender
          } label: {
            Text("Calender")
            
          }
        Spacer()

          .onAppear(perform: {
            Task {
                await viewModel.callGetFiltersApi()
            }
          })
      
      .navigationDestination(for: Route.self) { route in
          if route == .changePassword {
              ChangePasswordView()
          }else if route == .filterCalender {
              FilterCalnderHostView()
          }else if route == .profile {
            ProfileView()
          }
      }
    }
  }
}

#Preview {
    HomeView()
}
