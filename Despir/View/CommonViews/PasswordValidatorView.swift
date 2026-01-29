//
//  PasswordValidatorView.swift
//  Despir
//
//  Created by Prabhjot Singh on 29/01/26.
//

import SwiftUI

struct PasswordValidationView: View {
 
  @Binding var isAtleastEightChar: Bool
  @Binding var isAtleastOneUpper: Bool
  @Binding var isAtleastOneLower: Bool
  @Binding var isAtleastOneSpecial: Bool
  @Binding var isAtleastOneNumber: Bool
  
  var body: some View {
          VStack {
           
            VStackLayout(alignment: .leading, spacing: 2.0) {
              HStack {
                Image(isAtleastEightChar ? AppIcons.passValid : AppIcons.passInvalid)
                Text(MessageConstants.minimumEightCharacters)
                  .foregroundStyle(Color(hex: isAtleastEightChar ? ColorConstants.passwordValidColor : ColorConstants.passwordInValidColor))
                  .font(.poppinsRegular(size: 12))
                Spacer()
              }
              HStack {
                Image(isAtleastOneLower ? AppIcons.passValid : AppIcons.passInvalid)
                Text(MessageConstants.oneLowerCase)
                  .foregroundStyle(Color(hex: isAtleastOneLower ? ColorConstants.passwordValidColor : ColorConstants.passwordInValidColor))
                  .font(.poppinsRegular(size: 12))
                Spacer()
              }
              HStack {
                Image(isAtleastOneUpper ? AppIcons.passValid : AppIcons.passInvalid)
                Text(MessageConstants.oneUpperCase)
                  .foregroundStyle(Color(hex: isAtleastOneUpper ? ColorConstants.passwordValidColor : ColorConstants.passwordInValidColor))
                  .font(.poppinsRegular(size: 12))
                Spacer()
              }
              HStack {
                Image(isAtleastOneNumber ? AppIcons.passValid : AppIcons.passInvalid)
                Text(MessageConstants.oneNumber)
                  .foregroundStyle(Color(hex: isAtleastOneNumber ? ColorConstants.passwordValidColor : ColorConstants.passwordInValidColor))
                  .font(.poppinsRegular(size: 12))
                Spacer()
              }
              HStack {
                Image(isAtleastOneSpecial ? AppIcons.passValid : AppIcons.passInvalid)
                Text(MessageConstants.oneSpecialCharacter)
                  .foregroundStyle(Color(hex: isAtleastOneSpecial ? ColorConstants.passwordValidColor : ColorConstants.passwordInValidColor))
                  .font(.poppinsRegular(size: 12))
                Spacer()
              }
            }
          }
    }
}
#Preview {
  PasswordValidationView(isAtleastEightChar: .constant(false), isAtleastOneUpper: .constant(false), isAtleastOneLower: .constant(false), isAtleastOneSpecial: .constant(false), isAtleastOneNumber: .constant(true))
}
