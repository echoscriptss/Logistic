//
//  VerifyViewModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 06/01/26.
//

import Foundation
internal import Combine
import APIManager

class VerifyViewModel: ObservableObject {
  
  // MARK: - Variables
  
  var temporaryToken: String = String()
  @Published var otp: [String] = Array(repeating: "", count: 6)
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var verifyData: VerifyResponseModel?
  
  
  init(temporaryToken: String) {
    self.temporaryToken = temporaryToken
  }
  
  func callVerifyApi() async {
    
    let inputData = VerifyInputModel(temporaryToken: temporaryToken, otp: otp.joined())
        do {
          verifyData = try await APIManager.shared.request(url: EndPoint.verifyMfa.url, methodType: EndPoint.verifyMfa.httpMethod.rawValue, body: inputData, responseType: VerifyResponseModel.self)
          if verifyData?.statusCode != nil {
            errorMessage = verifyData?.message
            showAlert = true
          } else {
            DataManager.userToken = verifyData?.data?.token
            DataManager.userUuid = verifyData?.data?.profile?.uuid
          }
          print(verifyData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
  
  func callResendOtpApi() async {
    
    let inputData = resendInputModel(temporaryToken: temporaryToken)
        do {
          _ = try await APIManager.shared.request(url: EndPoint.resendOtpMfa.url, methodType: EndPoint.resendOtpMfa.httpMethod.rawValue, body: inputData, responseType: ResendOtpResponseModel.self)
          if verifyData?.statusCode != nil {
            errorMessage = verifyData?.message
            showAlert = true
          }
          print(verifyData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
}

