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
  
  var body: some View {
    
    CustomNavigationBar(title: "Change Password") {
      appRootManager.pop()
    }
    
    VStack {
      ScrollView {
        Spacer().frame(height: 30)
        HStack {
          Spacer().frame(width: 20)
          CustomSecureTestField(title: " Enter Current Password ", icon: AppIcons.password, text: $viewModel.oldPassword, isValid: .constant(true), isShowHide: false)
          Spacer().frame(width: 20)
        }
        
        HStack {
          Spacer().frame(width: 20)
          CustomSecureTestField(title: " Enter New Password ", icon: AppIcons.password, text: $viewModel.password, isValid: .constant(true), isShowHide: false)
          Spacer().frame(width: 20)
        }
        .onChange(of: viewModel.password) { _,_ in
          viewModel.checkPasswordValidation()
          viewModel.password = viewModel.password.replacingOccurrences(of: " ", with: "")
        }
        HStack {
          Spacer().frame(width: 20)
          CustomSecureTestField(title: " Confirm New Password ", icon: AppIcons.password, text: $viewModel.confirmPassword, isValid: .constant(true), isShowHide: false)
          Spacer().frame(width: 20)
        }
        
        HStack {
          Spacer().frame(width: 30)
          PasswordValidationView(isAtleastEightChar: $viewModel.isAtleastEightChar, isAtleastOneUpper: $viewModel.isAtleastOneUpper, isAtleastOneLower: $viewModel.isAtleastOneLower, isAtleastOneSpecial: $viewModel.isAtleastOneSpecial, isAtleastOneNumber: $viewModel.isAtleastOneNumber)
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
      Spacer()
      AsyncActionButton {
        if viewModel.validateUserInputs() {
          Task {
            await viewModel.callChangePasswordApi()
            if viewModel.changePasswordData != nil && viewModel.changePasswordData?.statusCode == nil {
            }
          }
        }
      } label: {
        Text("Update Password")
          .frame(maxWidth: .infinity)
          .font(.poppinsSemiBold(size: 14))
      }
      .frame(height: 44)
      Spacer().frame(height: 40)
    }.ignoresSafeArea()
  }
}

#Preview {
  ChangePasswordView()
}
