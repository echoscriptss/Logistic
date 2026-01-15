//
//  ForgotPasswordViewModel.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//
import APIManager
internal import Combine
import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var showAlert: Bool = false
    @Published var isSuccess: Bool = false
    @Published var forgotPasswordData: ForgotPasswordResponseModel?
    
    
    func callForgotPasswordApi(email: String) async {
        let inputData = ForgotPasswordModel(email: email)
        do
        {
            forgotPasswordData = try await APIManager.shared.request(url: EndPoint.forgotPassword.url, methodType: EndPoint.forgotPassword.httpMethod.rawValue,body: inputData, responseType: ForgotPasswordResponseModel.self)
            print(forgotPasswordData ?? "no data")
           if forgotPasswordData?.statusCode != nil {
                errorMessage = forgotPasswordData?.message
                showAlert = true // ?
               isSuccess = !showAlert
            } else {
                // Show alert is added in both case as message in success and failure case is to be show in alert.
                showAlert = true
                isSuccess = showAlert
                if let msg = forgotPasswordData?.message, !msg.isEmpty {
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
