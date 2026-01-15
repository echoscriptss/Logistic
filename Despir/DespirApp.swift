//
//  DespirApp.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI
import SwiftData

@main
struct DespirApp: App {
  @StateObject private var appRootManager = AppRootManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

  var body: some Scene {
    WindowGroup {
      ApplicationSwitcher()
    }
    .modelContainer(sharedModelContainer)
    .environmentObject(appRootManager)
  }
}

struct ApplicationSwitcher: View {
    
  @EnvironmentObject var appRootManager: AppRootManager
    
    var body: some View {
      switch appRootManager.currentRoot {
      case .splash:
        SplashView()
        
      case .login:
        NavigationStack(path: $appRootManager.path) {
          LoginView()
        }
      case .mainView:
        
        NavigationStack(path: $appRootManager.path) {
          MainContainerView()
        }
//      case .forgotPassword:
//        NavigationStack(path: $appRootManager.path) {
//         // ForgotPasswordView()
//        }
      }
    }
}
