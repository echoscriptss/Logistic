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
  @Published var isAtleastEightChar = false
  @Published var isAtleastOneUpper = false
  @Published var isAtleastOneLower = false
  @Published var isAtleastOneSpecial = false
  @Published var isAtleastOneNumber = false
  @Published var changePasswordData: ChangePasswordResponseModel?

  // Validations Methods

  func checkPasswordValidation() {
    isAtleastEightChar = password.count >= 8
    isAtleastOneNumber = password.isContainsNumbers()
    isAtleastOneUpper = password.isContainsCapChar()
    isAtleastOneLower = password.isContainsSmallChar()
    isAtleastOneSpecial = password.isContainsSpecialChar()
  }

  func validatations() -> ValidationResult {
    if oldPassword.isEmpty {
      return ValidationResult(success: false, errorMessage: MessageConstants.pleaseEnterPassword)
    } else if password.isEmpty {
      return ValidationResult(success: false, errorMessage: MessageConstants.pleaseEnterNewPassword)
    } else if confirmPassword.isEmpty {
      return ValidationResult(success: false, errorMessage: MessageConstants.pleaseEnterConfirmPassword)
    } else if !isAtleastEightChar || !isAtleastOneNumber || !isAtleastOneUpper || !isAtleastOneLower || !isAtleastOneSpecial {
      return ValidationResult(success: false, errorMessage: MessageConstants.pleaseEnterValidNewPassword)
    } else if password != confirmPassword {
      return ValidationResult(success: false, errorMessage: MessageConstants.passwordConfirmPasswordSame)
    }
    return ValidationResult(success: true, errorMessage: nil)
  }
  
  func validateUserInputs() -> Bool {
    
    let result = self.validatations()
    if result.success == false {
      errorMessage = result.errorMessage ?? "Error Occured"
      showAlert = true
      return false
    }
    
    return true
  }
  
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

