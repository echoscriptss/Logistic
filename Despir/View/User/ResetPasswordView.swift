//
//  ResetPasswordView.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//
import SwiftUI
import APIManager
import ValidationManager


struct ResetPasswordView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    private let validator = PasswordValidator()
    @ObservedObject var resetPasswordViewModel = ResetPasswordViewModel()
    @EnvironmentObject var appRootManager: AppRootManager

    private var validationResult: PasswordValidationResult {
        validator.validate(
            password: password,
            confirmPassword: confirmPassword
        )
    }
    
    var body: some View {
        Text("Reset Password")
            .font(.system(size: 36.0).bold())
            .padding(.bottom,40)
        Spacer()
        VStack(spacing: 16) {
            
            SecureField("New Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            if validationResult != .valid {
                Text(validationResult.message)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Reset Password") {
                print("API Call")
                Task {
                   await resetPasswordViewModel.callResetPassword(password: password, confirmPassword: confirmPassword)
                }
            }
            .disabled(validationResult != .valid)
            .opacity(validationResult == .valid ? 1 : 0.5)
            .alert(resetPasswordViewModel.isSuccess ? "Success" : "Error", isPresented: $resetPasswordViewModel.showAlert) {
                Button("OK", role: .cancel) {
                    if resetPasswordViewModel.isSuccess {
                        appRootManager.reset()
                    }
                }
            } message: {
                
                Text(resetPasswordViewModel.isSuccess ? "\(resetPasswordViewModel.successMessage ?? "")" : "\(resetPasswordViewModel.errorMessage ?? "")")
            }

        }
        Spacer()
        .padding()
    }
}
    

    
    
#Preview {
    ResetPasswordView()

}
