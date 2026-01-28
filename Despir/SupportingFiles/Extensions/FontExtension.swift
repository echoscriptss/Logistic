//
//  FontExtension.swift
//  Despir
//
//  Created by Prabhjot Singh on 28/01/26.
//

import SwiftUI

extension Font {
  
  static func poppinsBold(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-Bold", size: size)
    return font
  }
  static func poppinsRegular(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-Regular", size: size)
    return font
  }
  static func poppinsLight(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-Light", size: size)
    return font //
  }
  static func poppinsSemiBold(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-SemiBold", size: size)
    return font
  }
  static func poppinsMedium(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-Medium", size: size)
    return font
  }
  static func poppinsThin(size: CGFloat) -> Font? {
    let font = Font.custom("Poppins-Thin", size: size)
    return font
  }
}
