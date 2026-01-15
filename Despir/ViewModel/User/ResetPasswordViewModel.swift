//
//  ResetPasswordViewModel.swift
//  Despir
//
//  Created by Yogesh on 1/8/26.
//

import APIManager
internal import Combine
import Foundation

class ResetPasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var showAlert: Bool = false
    @Published var isSuccess: Bool = false
    @Published var verifyResetPasswordResponse: ResetPasswordResponseModel?
    
    func callResetPassword(password: String, confirmPassword: String) async {

        let InputData = ResetPasswordModel(password: password, confirmpassword: confirmPassword)
        do {
            verifyResetPasswordResponse = try await  APIManager.shared.request(url: EndPoint.resetPassword.url, methodType: EndPoint.resetPassword.httpMethod.rawValue, headers: EndPoint.resetPassword.headers ,body: InputData, responseType: ResetPasswordResponseModel.self)
            if verifyResetPasswordResponse?.statusCode != nil {
                errorMessage = verifyResetPasswordResponse?.message
                showAlert = true // ?
                isSuccess = !showAlert
            } else {
                // Show alert is added in both case as message in success and failure case is to be show in alert.
                showAlert = true
                isSuccess = showAlert
                if let msg = verifyResetPasswordResponse?.message, !msg.isEmpty {
                    successMessage = msg
                }
            }
        }
        catch {
            errorMessage = error.localizedDescription
            showAlert = true // ?
            isSuccess = !showAlert
        }
    }
    
    
}
