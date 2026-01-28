//
//  AccountView.swift
//  Despir
//
//  Created by Prabhjot Singh on 27/01/26.
//

import SwiftUI

struct AccountView: View {
  
  @EnvironmentObject var appRootManager: AppRootManager
  
  var body: some View {
    VStack {
      CustomNavigationBar(title: "Account", showBack: false, showLogo: true)
      Spacer().frame(height: 0)
      // Profile View
      HStack {
        Spacer().frame(width: 20)
        VStack {
          Spacer().frame(height: 20)
          Image("")
            .resizable()
            .frame(width: 50, height: 50)
            .background(Color(hex: ColorConstants.buttonTittleColor))
            .cornerRadius(25)
          
          Spacer()
        }
        Spacer().frame(width: 20)
        
        VStack(alignment: .leading) {
          Text("John Doe")
            .font(.poppinsSemiBold(size: 16))
          
          Text(verbatim: "john.doe@xy.com")
            .foregroundStyle(.black)
            .font(.poppinsRegular(size: 12))
          
          Text("Driver")
            .font(.poppinsMedium(size: 12))
          Button {
            appRootManager.push(.changePassword)
          } label: {
            HStack {
              Spacer()
              Text("Change Password")
                .font(.poppinsMedium(size: 12))
                .foregroundStyle(Color(hex: ColorConstants.buttonTittleColor))
              Spacer()
            }
          }
          .frame(width: 260, height: 30)
          .overlay(
            Capsule()
              .stroke(Color(hex: ColorConstants.buttonTittleColor), lineWidth: 1)
          )
        }
        
        Spacer()
      }
      .frame(height: 147)
      .background(Color(hex: ColorConstants.lightGray))
      // Buttons
      Spacer().frame(height: 0)
      Divider()
      Button {
        
      } label: {
        HStack {
          Spacer().frame(width: 20)
          Image(AppIcons.contactUs)
          Spacer().frame(width: 20)
          Text("Privacy Policy")
            .font(.poppinsMedium(size: 14))
            .foregroundStyle(Color(hex: ColorConstants.buttonTittleColor))
          
          Spacer()
        }
      }.frame(height: 60)
      Divider()
      Button {
        
      } label: {
        HStack {
          Spacer().frame(width: 20)
          Image(AppIcons.termsOfUse)
          Spacer().frame(width: 20)
          Text("Terms Of Use")
            .font(.poppinsMedium(size: 14))
            .foregroundStyle(Color(hex: ColorConstants.buttonTittleColor))
          
          Spacer()
        }
      }.frame(height: 60)
      Divider()
      Button {
        
      } label: {
        HStack {
          Spacer().frame(width: 20)
          Image(AppIcons.contactUs)
          Spacer().frame(width: 20)
          Text("Contact Us")
            .font(.poppinsMedium(size: 14))
            .foregroundStyle(Color(hex: ColorConstants.buttonTittleColor))
          
          Spacer()
        }
      }.frame(height: 60)
      Divider()
      Spacer()
      
      Button {
        appRootManager.currentRoot = .login
      } label: {
        HStack {
          Spacer()
          Text("Logout")
            .font(.poppinsSemiBold(size: 14))
            .foregroundStyle(Color(hex: ColorConstants.buttonTittleColor))
          Spacer()
        }
        .frame(height: 55)
        .overlay {
          Rectangle()
            .stroke(Color(hex: ColorConstants.buttonTittleColor), lineWidth: 1)
        }
        
      }.frame(height: 55)
        .background(Color(hex: ColorConstants.lightGray))
        .padding(20)
      
    }
    .navigationDestination(for: Route.self) { route in
      if route == .changePassword {
        ChangePasswordView()
      }
    }
  }
}

#Preview {
    AccountView()
}
