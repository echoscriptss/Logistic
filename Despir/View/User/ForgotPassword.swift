//
//  ForgotPassword.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//

import SwiftUI
import APIManager
import ValidationManager


struct ForgotPassword: View {
    @State private var email = "yogeshwh@yopmail.com"
    @State private var otp = ""
    @State private var isEmailValid = true
    let emailValidator = EmailValidator()

    @ObservedObject var forgotPasswordViewModel = ForgotPasswordViewModel()
    @ObservedObject var verifyOTPViewModel = VerifyOTPViewModel()
    @EnvironmentObject var appRootManager: AppRootManager

    var body: some View {
        VStack {
            Text(forgotPasswordViewModel.forgotPasswordData == nil ? "Forgot Password" : "Verify OTP")
                .font(.system(size: 36.0).bold())
                .padding(.bottom,40)
            TextField("Please Enter Email", text: $email)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.bottom],10)
                .padding([.leading,.trailing],10)
                .onChange(of: email) { _, newValue in
                    isEmailValid = newValue.isEmpty
                        ? true
                        : emailValidator.isValid(email: newValue)
                }
                .disabled(forgotPasswordViewModel.forgotPasswordData != nil)
                .opacity(forgotPasswordViewModel.forgotPasswordData != nil ? 0.4 : 1)
            if !isEmailValid {
                Text("Please enter a valid email address")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 10)
            }

            if forgotPasswordViewModel.forgotPasswordData != nil {
                TextField("Enter 6-digit code", text: $otp)
                    .keyboardType(.numberPad)

                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.bottom],10)
                    .padding([.leading,.trailing],10)
                    .onDisappear {
                            otp = ""
                        }
                    .onChange(of: otp) { oldValue, newValue in
                            otp = String(newValue.filter(\.isNumber).prefix(6))
                        }
                
                Button {
                    //appRootManager.push()
                    Task {
                        await verifyOTPViewModel.callVerifyOTP(email: email, optCode: otp)
                    }
                } label: {
                    Text("Verify OTP")
                }
                .alert(verifyOTPViewModel.isSuccessOTP ? "Success" : "Error", isPresented: $verifyOTPViewModel.showAlertOTP) {
                    Button("OK", role: .cancel) {
                        if verifyOTPViewModel.isSuccessOTP {
                            
                            if let token = verifyOTPViewModel.verifyOTPResponse?.data, !token.isEmpty {
                                DataManager.userToken = token
                            }
//                            DataManager.userToken = verifyOTPViewModel.verifyOTPResponse?.data
                            print(verifyOTPViewModel.verifyOTPResponse?.data)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                appRootManager.push(.resetPassword)
                                
                            }
                        }
                    }
                } message: {
                    
                    Text(verifyOTPViewModel.isSuccessOTP ? "\(verifyOTPViewModel.successMessage ?? "")" : "\(verifyOTPViewModel.errorMessage ?? "")")
                }

                
            } else {
                Button {
                    Task {
                        await forgotPasswordViewModel.callForgotPasswordApi(email: email)
                        if forgotPasswordViewModel.forgotPasswordData != nil && forgotPasswordViewModel.forgotPasswordData?.statusCode == nil {
                            // navigate here
                        }
                    }
                } label: {
                    Text("Send Verification Code")
                }
                .disabled(!isEmailValid || email.isEmpty)
                .opacity(isEmailValid && !email.isEmpty ? 1 : 0.5)
                .alert(forgotPasswordViewModel.isSuccess ? "Success" : "Error", isPresented: $forgotPasswordViewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(forgotPasswordViewModel.isSuccess ? "\(forgotPasswordViewModel.successMessage ?? "")" : "\(forgotPasswordViewModel.errorMessage ?? "")")
                }
        }
            Spacer()

        }

    }
}

#Preview {
    ForgotPassword()
}
