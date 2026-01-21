//
//  CustomTabbar.swift
//  Despir
//
//  Created by Prabhjot Singh on 21/01/26.
//

import SwiftUI
internal import Combine

enum Tab: String, CaseIterable {
    case home = "Home"
    case settings = "Settings"
   

    var icon: String {
        switch self {
        case .home: return AppIcons.home
        case .settings: return AppIcons.settings
        
        }
    }
}
struct CustomTabbar: View {
  
  @Binding var selectedTab: Tab

     var body: some View {
         HStack {
             ForEach(Tab.allCases, id: \.self) { tab in
                 Button {
                     selectedTab = tab
                 } label: {
                     VStack(spacing: 4) {
                         Image(tab.icon)
                             .font(.system(size: 22))
                             
                         Text(tab.rawValue)
                         .font(selectedTab == tab ? .system(size: 12,weight: .bold) : .system(size: 12))
                     }
                     .foregroundColor(selectedTab == tab ? .black : .black.opacity(0.5))
                     .frame(maxWidth: .infinity)
                 }
             }
         }
         .padding(.vertical, 8)
         .background(Color.white)
     }
}


struct MainTabView: View {

    @State private var selectedTab: Tab = .home
    @EnvironmentObject var tabBarController: TabBarController
  
    var body: some View {
        VStack(spacing: 0) {

            // 👇 Screen changes here
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .settings:
                    ChangePasswordView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

          if !tabBarController.isHidden {
            Divider()
            CustomTabbar(selectedTab: $selectedTab)
          }
           
        }
    }
}

#Preview {
  MainTabView()
}

// this is for show/hide tabbar
final class TabBarController: ObservableObject {
    @Published var isHidden: Bool = false

    func hide() {
        isHidden = true
    }

    func show() {
        isHidden = false
    }
}
