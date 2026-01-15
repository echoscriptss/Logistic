//
//  VerifyOTPViewModel.swift
//  Despir
//
//  Created by Yogesh on 1/8/26.
//

import APIManager
internal import Combine
import Foundation

class VerifyOTPViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var showAlertOTP: Bool = false
    @Published var isSuccessOTP: Bool = false
    @Published var verifyOTPResponse: VerifyOTPResponseModel?
    
    func callVerifyOTP(email: String, optCode: String) async {
        let InputData = VerifyOTPModel(email: email, otp: optCode)
        do {
            verifyOTPResponse =  try await APIManager.shared.request(url: EndPoint.verifyOTP.url, methodType: EndPoint.verifyOTP.httpMethod.rawValue, body: InputData, responseType: VerifyOTPResponseModel.self)
            if verifyOTPResponse?.statusCode != nil {
                 errorMessage = verifyOTPResponse?.message
                showAlertOTP = true // ?
               isSuccessOTP = !showAlertOTP
             } else {
                 // Show alert is added in both case as message in success and failure case is to be show in alert.
                 showAlertOTP = true
                 isSuccessOTP = showAlertOTP
                 if let msg = verifyOTPResponse?.message, !msg.isEmpty {
                     successMessage = msg
                 }
            }
        }
        catch {
            errorMessage = error.localizedDescription
            showAlertOTP = true // ?
            isSuccessOTP = !showAlertOTP
        }
    }
}


