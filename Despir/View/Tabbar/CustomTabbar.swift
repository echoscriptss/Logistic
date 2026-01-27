//
//  CustomTabbar.swift
//  Despir
//
//  Created by Prabhjot Singh on 21/01/26.
//

import SwiftUI
internal import Combine

enum Tab: String, CaseIterable {
    case dashboard = "Dashboard"
    case shipments = "Shipments"
    case notifications = "Notifications"
    case accounts = "Accounts"

    var icon: String {
        switch self {
        case .dashboard: return AppIcons.dashboard
        case .shipments: return AppIcons.shipments
        case .notifications: return AppIcons.notifications
        case .accounts: return AppIcons.accounts
        }
    }
  
  var selectedIcon: String {
      switch self {
      case .dashboard: return AppIcons.dashboardSelected
      case .shipments: return AppIcons.shipmentsSelected
      case .notifications: return AppIcons.notifications
      case .accounts: return AppIcons.accounts
      }
  }
}

struct CustomTabbar: View {
  
  @Binding var selectedTab: Tab

     var body: some View {
         HStack {
           Spacer().frame(width: 10)
             ForEach(Tab.allCases, id: \.self) { tab in
               VStack {
                 Spacer().frame(height: 10)
                   VStack(spacing: 4) {
                     Image(selectedTab == tab ? tab.selectedIcon : tab.icon)
                       .font(.system(size: 22))
                     
                     Text(tab.rawValue)
                       .font(.system(size: 12))
                   }
                   .foregroundColor(selectedTab == tab ? .white : .black.opacity(0.6))
                   .frame(maxWidth: .infinity)
                   .onTapGesture {
                     selectedTab = tab
                   }
                 Spacer().frame(height: 10)
               } .background(selectedTab == tab ? .black : .white)
                 .cornerRadius(10)
             }
           Spacer().frame(width: 10)
         }
         .padding(.vertical, 8)
         .background(Color.white)
     }
}


struct MainTabView: View {

    @State private var selectedTab: Tab = .dashboard
    @EnvironmentObject var tabBarController: TabBarController
  
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .dashboard:
                    HomeView()
                case .shipments:
                    ChangePasswordView()
                case .notifications:
                    ChangePasswordView()
                case .accounts:
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
