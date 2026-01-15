//
//  DataManager.swift
//  Despir
//
//  Created by Prabhjot Singh on 18/12/25.
//

import Foundation

private enum Defaults: String {
   
    case isUserLoggedIn = "isUserLoggedIn"
    case userToken = "token"
    case userUuid = "userUuid"
}

final class DataManager {
  
  private static func _set(value: Any?, key: Defaults) {
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }
  
  private static func _get(valueForKay key: Defaults) -> Any? {
    return UserDefaults.standard.value(forKey: key.rawValue)
  }
  
  private static func _delete(valueForKay key: Defaults) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
  
  static var isUserLoggedIn: Bool? {
      get {
        return _get(valueForKay: .isUserLoggedIn) as? Bool
      }
      set {
          _set(value: newValue, key: .isUserLoggedIn)
      }
  }
  
  static var userToken: String? {
      get {
        return _get(valueForKay: .userToken) as? String
      }
      set {
          _set(value: newValue, key: .userToken)
      }
  }
  
  static var userUuid: String? {
      get {
        return _get(valueForKay: .userUuid) as? String
      }
      set {
          _set(value: newValue, key: .userUuid)
      }
  }
}

struct DefaultStore {
    static let key = "default_user_type"

    static func save(_ type: UserType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }

    static func load() -> UserType? {
        guard let value = UserDefaults.standard.string(forKey: key) else {
            return nil
        }
        return UserType(rawValue: value)
    }
}
