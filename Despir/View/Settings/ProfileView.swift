//
//  ProfileView.swift
//  Despir
//
//  Created by Prabhjot Singh on 12/01/26.
//

import SwiftUI

struct ProfileView: View {
  
  @EnvironmentObject var appRootManager: AppRootManager
  @ObservedObject private var viewModel = ProfileViewModel()
    var body: some View {
      VStack {
        Text("Profile")
          .font(.system(size: 36.0).bold())
          .padding(.bottom,40)
        TextField("First Name", text: $viewModel.firstName)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        TextField("Last Name", text: $viewModel.lastName)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        TextField("Phone Number", text: $viewModel.phone)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        AsyncActionButton {
            Task {
                await viewModel.callUpdateProfileApi()
                if viewModel.profileData != nil && viewModel.profileData?.statusCode == nil {
                
                  
                }
            }
        } label: {
            Text("Submit")
                .frame(maxWidth: .infinity)
        }
        .frame(height: 44)

      }
      .alert(viewModel.isSuccess ? "Success" : "Error", isPresented: $viewModel.showAlert) {
          Button("OK", role: .cancel) {
            if viewModel.isSuccess {
              appRootManager.pop()
            }
          }
      } message: {
          Text(viewModel.errorMessage ?? "")
      }

    }
}

#Preview {
  ProfileView()
}
