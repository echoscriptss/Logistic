//
//  ProfileViewModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 12/01/26.
//

import Foundation
internal import Combine
import APIManager

class ProfileViewModel: ObservableObject {
  
  // MARK: - Variables
  
  @Published var firstName: String = String()
  @Published var lastName: String = String()
  @Published var phone: String = String()
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var isSuccess: Bool = false
  @Published var profileData: ProfileResponseModel?
  
// MARK: - API Methods

  func callUpdateProfileApi() async {
    let inputData = ProfileInputModel(firstName: firstName, lastName: lastName, phone: phone)
    do {
      profileData = try await APIManager.shared.request(url: EndPoint.updateProfile.url, methodType: EndPoint.updateProfile.httpMethod.rawValue, headers: EndPoint.changePassword.headers, body: inputData, responseType: ProfileResponseModel.self)
        errorMessage = profileData?.message
        isSuccess = profileData?.statusCode == nil
        showAlert = true
    
      print(profileData ?? "")
    } catch {
      errorMessage = error.localizedDescription
      isSuccess = false
      showAlert = true
    }
  }
  
}

