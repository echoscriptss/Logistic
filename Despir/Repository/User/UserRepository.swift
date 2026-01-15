//
//  UserRepository.swift
//  Despir
//
//  Created by Prabhjot Singh on 18/12/25.
//

import Foundation
import SwiftData

@MainActor
class UserRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getUser() -> UserModel {
        let descriptor = FetchDescriptor<UserModel>()

        if let settings = try? context.fetch(descriptor).first {
            return settings
        }

        let user = UserModel()
        context.insert(user)
        return user
    }

    func addUser(user: UserModel) {
        let saveUser = getUser()
      saveUser.userId = user.userId
      saveUser.userName = user.userName
      saveUser.email = user.email
    }

}
