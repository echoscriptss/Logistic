//
//  LoginViewModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import Foundation
internal import Combine
import APIManager

class LoginViewModel: ObservableObject {
  
  // MARK: - Variables
  
  @Published var userEmail: String = String()
  @Published var userPassword: String = String()
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var loginData: LoginResponseModel?
  

  
    func callLoginApi(email: String, password: String) async {
    
    let inputData = LoginInputModel(email: email, password: password)
        do {
          loginData = try await APIManager.shared.request(url: EndPoint.login.url, methodType: EndPoint.login.httpMethod.rawValue, body: inputData, responseType: LoginResponseModel.self)
          if loginData?.statusCode != nil {
            errorMessage = loginData?.message
            showAlert = true // ?
          }
          print(loginData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true // ?
        }
    }
  
}

