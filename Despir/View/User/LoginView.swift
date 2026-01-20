//
//  LoginView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI
import APIManager
import ValidationManager

struct LoginView: View {
    @EnvironmentObject var appRootManager: AppRootManager
    @StateObject private var viewModel = LoginViewModel()
    @State private var isEmailValid = true
    @State private var username = "yogeshwh@yopmail.com"
    //    @State private var username = "Prabwh@yopmail.com"
    @State private var password = "Test@1234"
    let emailValidator = EmailValidator()


    var body: some View {
        VStack {
          Spacer().frame(height: 100)
          Image(AppIcons.eyeOnItLogo)
                .font(.system(size: 36.0).bold())
                .contextMenu {
                    Button("Dev") {
                        save(.Dev)
                    }
                    Button("UAT") {
                        save(.UAT)
                    }
                    Button("Prod") {
                        save(.Prod)
                    }
                }
            Spacer()
          HStack {
            Spacer().frame(width: 20)
            CustomTestField(title: " Email * ", icon: AppIcons.email, text: $username, isValid: $isEmailValid)
              .onChange(of: username) { _, newValue in
                isEmailValid = newValue.isEmpty
                ? true
                : emailValidator.isValid(email: newValue)
              }
            Spacer().frame(width: 20)
          }
          HStack {
            Spacer().frame(width: 20)
            CustomSecureTestField(title: " Password ", icon: AppIcons.password, text: $password, isValid: .constant(true))
            Spacer().frame(width: 20)
          }
         
            AsyncActionButton {
              Task {
                await viewModel.callLoginApi(email: username, password: password)
                if viewModel.loginData != nil && viewModel.loginData?.statusCode == nil {
                  appRootManager.push(.verification)
                }
              }
            } label: {
              Text("SignIn")
            }
            .disabled(!isEmailValid || username.isEmpty)
            .opacity(isEmailValid && !username.isEmpty ? 1 : 0.5)
          
            // Forgot password
          Button {
            appRootManager.push(.forgotPassword)
          } label: {
            Text("Forgot Password?")
              .underline()
              .foregroundColor(.black.opacity(0.6))
          }
          
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            
            Spacer()
        }
        .navigationDestination(for: Route.self) { route in
            if route == .verification {

                VerifyView(viewModel: VerifyViewModel(temporaryToken: viewModel.loginData?.temporaryToken ?? ""))
            }
            else if route == .forgotPassword {
                ForgotPassword()
            }
            else if route == .resetPassword {
                ResetPasswordView()
            }
        }
    }
    
    func save(_ type: UserType) {
        DefaultStore.save(type)
    }

}

#Preview {
    LoginView()
}
