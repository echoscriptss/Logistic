//
//  ResetPasswordModel.swift
//  Despir
//
//  Created by Yogesh on 1/8/26.
//
// INPUT MODEL
struct ResetPasswordModel: Encodable {
  let password: String?
  let confirmpassword: String?
}

// Response Model
// RESPONSE MODEL
struct ResetPasswordResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let data: dataModel?
  let statusCode: Int?
}
struct dataModel: Decodable {
  let success: Bool?
  let message: String?
}
