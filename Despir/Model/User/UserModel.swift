//
//  UserModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 18/12/25.
//

import Foundation
import SwiftData

//Swift Data Model
@Model
class UserModel {
    var userId: String?
    var userName: String?
    var email: String?

    init(userId: String = "", userName: String = "", email: String = "") {
        self.userId = userId
        self.userName = userName
        self.email = email
    }
}

//API Method
struct LoginResponseModel: Decodable {
  let mfaRequired: Bool?
  let temporaryToken: String?
  let phone: String?
  let message: String?
  let error: String?
  let statusCode: Int?
}


struct LoginInputModel: Encodable {
  let email: String?
  let password: String?
}
