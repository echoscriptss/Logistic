//
//  SplashView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI


struct SplashView: View {
  
  @EnvironmentObject var appRootManager: AppRootManager
  
    var body: some View {
        Text("Despir")
          .font(.system(size: 36.0).bold())
      .onAppear{
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          appRootManager.currentRoot =  Utils.isUserLoggedIn() ? .mainView : .login
        }
      }
    }
}

#Preview {
    SplashView()
}
