//
//  VerifyModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 06/01/26.
//

import Foundation

// API Input Model
struct VerifyInputModel: Encodable {
  let temporaryToken: String?
  let otp: String?
}
struct resendInputModel: Encodable {
  let temporaryToken: String?
}

// API Output Model
struct VerifyResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let data: VerifyDataModel?
  let statusCode: Int?
}

struct VerifyDataModel: Decodable {
  let success: Bool?
  let message: String?
  let token: String?
  let profile: VerifyProfileModel?
  
}

struct VerifyProfileModel: Decodable {
  let id: Int?
  let uuid: String?
  let firstName: String?
  let lastName: String?
  let email: String?
  let phone: String?
}

struct ResendOtpResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let statusCode: Int?
}
