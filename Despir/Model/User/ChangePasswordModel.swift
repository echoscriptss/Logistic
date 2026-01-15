//
//  ChangePasswordModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 08/01/26.
//

import Foundation

// API Input Model
struct ChangePasswordInputModel: Encodable {
  let oldPassword: String?
  let password: String?
  let confirmpassword: String?
}

// RESPONSE MODEL
struct ChangePasswordResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let statusCode: Int?
}
