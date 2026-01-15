//
//  ChangePasswordVM.swift
//  Despir
//
//  Created by Prabhjot Singh on 08/01/26.
//

import Foundation
internal import Combine
import APIManager

class ChangePasswordVM: ObservableObject {
  
  // MARK: - Variables
  
  @Published var oldPassword: String = String()
  @Published var password: String = String()
  @Published var confirmPassword: String = String()
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var isSuccess: Bool = false
  @Published var changePasswordData: ChangePasswordResponseModel?


  // MARK: - API Methods
    func callChangePasswordApi() async {
    
      let inputData = ChangePasswordInputModel(oldPassword: oldPassword, password: password, confirmpassword: confirmPassword)
        do {
          changePasswordData = try await APIManager.shared.request(url: EndPoint.changePassword.url, methodType: EndPoint.changePassword.httpMethod.rawValue,headers: EndPoint.changePassword.headers ,body: inputData, responseType: ChangePasswordResponseModel.self)
         
        //  if changePasswordData?.statusCode != nil {
            errorMessage = changePasswordData?.message
            isSuccess = changePasswordData?.statusCode == nil
            showAlert = true // ?
         // }
          print(changePasswordData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            isSuccess = false
            showAlert = true // ?
        }
    }
}

