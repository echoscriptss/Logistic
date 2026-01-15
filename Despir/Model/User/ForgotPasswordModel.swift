//
//  ForgotPasswordModel.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//

// INPUT MODEL
struct ForgotPasswordModel: Encodable {
  let email: String?
}

// RESPONSE MODEL
struct ForgotPasswordResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let data: String?
  let statusCode: Int?
}

