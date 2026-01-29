//
//  StringExtention.swift
//  Despir
//
//  Created by Prabhjot Singh on 29/01/26.
//

import Foundation

extension String {
  
  func isContainsNumbers() -> Bool {
      // check if there's a number
      let numberRegEx  = ".*[0-9]+.*"
      let textTestNum = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
      let numberResult = textTestNum.evaluate(with: self)
      // false if no number is found
      return numberResult
  }
  
  func isContainsCapChar() -> Bool {
      // check if there's a Upper case
      let capitalLetterRegEx  = ".*[A-Z]+.*"
      let textTestCap = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
      let capResult = textTestCap.evaluate(with: self)
      // false if no capital char is found
      return capResult
  }
  
  func isContainsSmallChar() -> Bool {
      // check if there's a Small case
      let smallLetterRegEx  = ".*[a-z]+.*"
      let textTestSmall = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
      let smallResult = textTestSmall.evaluate(with: self)
      // false if no Small char is found
      return smallResult
  }
    
  func isContainsSpecialChar() -> Bool {
      // check if there's a Special case
      let specialLetterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
      let textTestSpecial = NSPredicate(format:"SELF MATCHES %@", specialLetterRegEx)
      let specialResult = textTestSpecial.evaluate(with: self)
      // false if no Special char is found
      return specialResult
  }
  
}
