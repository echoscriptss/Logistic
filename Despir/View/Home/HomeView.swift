import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var appRootManager: AppRootManager
    @ObservedObject var viewModel = ShipmentsViewModel()
    
    var body: some View {
        ZStack {
            
            // 🔹 MAIN CONTENT (Never moves)
            VStack {
                Spacer().frame(height: 50)
                
                Text("Home Screen")
                    .font(.system(size: 36).bold())
                
                Spacer()
                
                Text("Long press for settings")
                    .font(.system(size: 20).bold())
                    .contextMenu {
                        Button("Update Profile") {
                            appRootManager.push(.profile)
                        }
                        Button("Change Password") {
                            appRootManager.push(.changePassword)
                        }
                    }
                
                Spacer()
                
                Button("Logout") {
                    DataManager.isUserLoggedIn = false
                    appRootManager.currentRoot = .login
                }
                
                Spacer()
                
                Button("Calender") {
                    appRootManager.currentRoot = .filterCalender
                }
                
                Spacer()

                    .onAppear {
                        Task {
                            await viewModel.callGetFiltersApi()
                        }
                    }
                
                    .navigationDestination(for: Route.self) { route in
                        if route == .changePassword {
                            ChangePasswordView()
                        }else if route == .filterCalender {
                            DateSelectionView()
                        }
                        else if route == .profile {
                            ProfileView()
                        }
                    }
            }
            
        }
    }
}


