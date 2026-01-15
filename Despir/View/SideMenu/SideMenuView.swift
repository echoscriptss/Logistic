//
//  SideMenuView.swift
//  Despir
//
//  Created by Prabhjot Singh on 13/01/26.
//

import SwiftUI

struct SideMenuContainer<Content: View>: View {

    @Binding var isOpen: Bool
    private let menuWidth: CGFloat = 250

    let content: Content
    let menu: SideMenuView

    init(
        isOpen: Binding<Bool>,
        menu: SideMenuView,
        @ViewBuilder content: () -> Content
    ) {
        self._isOpen = isOpen
        self.menu = menu
        self.content = content()
    }

    var body: some View {
      GeometryReader { geo in
               ZStack(alignment: .leading) {

                   content
                       .frame(width: geo.size.width, height: geo.size.height)

                   menu
                       .frame(width: menuWidth)
                       .offset(x: isOpen ? 0 : -menuWidth)
               }
               .animation(.easeInOut(duration: 0.25), value: isOpen)
           }
           .ignoresSafeArea()
           }

    private func close() {
        withAnimation {
            isOpen = false
        }
    }
}

enum MainScreen {
    case home
    case profile
    case changePassword
}

struct SideMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let screen: MainScreen
}

enum SideMenuData {
    static let items: [SideMenuItem] = [
        .init(title: "Home", icon: "house", screen: .home),
        .init(title: "Profile", icon: "person", screen: .profile),
        .init(title: "Change Password", icon: "lock", screen: .changePassword)
    ]
}

struct SideMenuView: View {
  
  let items: [SideMenuItem]
  let onSelect: (MainScreen) -> Void
  
  var body: some View {
    HStack {
      Spacer().frame(width: 25)
      VStack(alignment: .leading, spacing: 24) {
        Spacer().frame(height: 100)
        // Header
        VStack(alignment: .leading, spacing: 8) {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 60, height: 60)
          Text("Prabhjot Singh")
            .font(.headline)
        }
        
        // Menu Items
        ForEach(items) { item in
          Button {
            onSelect(item.screen)
          } label: {
            HStack(spacing: 16) {
              Image(systemName: item.icon)
                .frame(width: 24)
              Text(item.title)
              Spacer()
            }
          }
        }
        
        Spacer()
      }
    }
    
    // .frame(width: 250)
    .background(Color.white)
    //  .ignoresSafeArea()
    .overlay(alignment: .trailing) {
      HStack {
        Divider()
          .background(Color.gray.opacity(0.4))
      }
    }
  }
}
struct MainContainerView: View {

    @State private var selectedScreen: MainScreen = .home
    @State private var isMenuOpen = false

    var body: some View {
        SideMenuContainer(
            isOpen: $isMenuOpen,
            menu: SideMenuView(
                items: SideMenuData.items,
                onSelect: selectScreen
            )
        ) {
            ZStack {
                contentView
                .blur(radius: isMenuOpen ? 2 : 0)
                .animation(.easeInOut(duration: 0.25), value: isMenuOpen)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isMenuOpen.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
    }

    private func selectScreen(_ screen: MainScreen) {
        selectedScreen = screen
        isMenuOpen = false
    }

    @ViewBuilder
    private var contentView: some View {
        switch selectedScreen {
        case .home:
            HomeView()
        case .profile:
            ProfileView()
        case .changePassword:
            ChangePasswordView()
        }
    }
}
