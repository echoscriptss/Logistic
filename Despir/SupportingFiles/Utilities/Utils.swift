//
//  Utils.swift
//  Despir
//
//  Created by Prabhjot Singh on 17/12/25.
//

import Foundation


enum Utils {
  
  static func isUserLoggedIn() -> Bool {
    return DataManager.isUserLoggedIn ?? false
  }
}
