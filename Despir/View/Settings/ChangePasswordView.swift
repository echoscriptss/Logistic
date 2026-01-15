//
//  ChangePasswordView.swift
//  Despir
//
//  Created by Prabhjot Singh on 08/01/26.
//

import SwiftUI
import ValidationManager

struct ChangePasswordView: View {
  
  @EnvironmentObject var appRootManager: AppRootManager
  @ObservedObject private var viewModel = ChangePasswordVM()
  @State private var passwordMessage = String()
    var body: some View {
      VStack {
        Text("Change Password")
            .font(.system(size: 36.0).bold())
            .padding(.bottom,40)
        
        SecureField("Old Password", text: $viewModel.oldPassword)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        SecureField("Password", text: $viewModel.password)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        if !passwordMessage.isEmpty {
          Text(passwordMessage)
            .foregroundStyle(.red)
        }
        SecureField("Confirm Password", text: $viewModel.confirmPassword)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
            
        // Submit button
        AsyncActionButton {
            Task {
                await viewModel.callChangePasswordApi()
                if viewModel.changePasswordData != nil && viewModel.changePasswordData?.statusCode == nil {
                   
                }
            }
        } label: {
            Text("Submit")
                .frame(maxWidth: .infinity)
        }
        .frame(height: 44)
        .alert(viewModel.isSuccess ? "Success" : "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
              if viewModel.isSuccess {
                appRootManager.pop()
              }
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .onChange(of: viewModel.password) { _, newValue in
          passwordMessage = PasswordValidator().validate(password: newValue).message
        }
      }
    }
}

#Preview {
    ChangePasswordView()
}
