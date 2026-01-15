//
//  ProfileModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 12/01/26.
//

import Foundation

// API Input Model
struct ProfileInputModel: Encodable {
  let firstName: String?
  let lastName: String?
  let phone: String?
}

// RESPONSE MODEL
struct ProfileResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let statusCode: Int?
}
