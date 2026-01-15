//
//  VerifyOTPModel.swift
//  Despir
//
//  Created by Yogesh on 1/8/26.
//

//---------------------------------
// INPUT MODEL
struct VerifyOTPModel: Encodable {
  let email: String?
  let otp: String?
}

// RESPONSE MODEL
struct VerifyOTPResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let data: String?
  let statusCode: Int?
}
