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
      case .notifications: return AppIcons.notificationsSelected
      case .accounts: return AppIcons.accountSelected
      }
  }
  
  var supportsBadge: Bool {
        self == .notifications
    }
}

struct BadgeView: View {
    let count: Int

    var body: some View {
        if count > 0 {
            Text(count > 99 ? "99+" : "\(count)")
              .font(.system(size: 10, weight: .bold))
              .foregroundColor(.white)
              .padding(5)
              .background(Color.red)
              .clipShape(Capsule())
              .offset(x: 10, y: -8)
        }
    }
}

struct CustomTabbar: View {
  
  @Binding var selectedTab: Tab
  var notificationCount: Int = 0

     var body: some View {
         HStack {
           Spacer().frame(width: 10)
             ForEach(Tab.allCases, id: \.self) { tab in
               VStack {
                 Spacer().frame(height: 10)
                   VStack(spacing: 4) {
                     ZStack(alignment: .topTrailing) {
                       
                       Image(selectedTab == tab ? tab.selectedIcon : tab.icon)
                       
                       if tab.supportsBadge {
                           BadgeView(count: notificationCount)
                           .alignmentGuide(.trailing) { d in
                                           d[.trailing] - 2
                                       }
                       }
                     }
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
    @State private var notificationCount = 5 // dynamic
  
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .dashboard:
                    Dashboard()
                case .shipments:
                    ShipmentsView()
                case .notifications:
                    NotificationsView()
                    .onAppear {
                      notificationCount = 0 // clear badge
                    }
                case .accounts:
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

          if !tabBarController.isHidden {
            Divider()
            CustomTabbar(selectedTab: $selectedTab, notificationCount: notificationCount)
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
