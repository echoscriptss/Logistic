//
//  VerifyView.swift
//  Despir
//
//  Created by Prabhjot Singh on 07/01/26.
//

import SwiftUI

struct VerifyView: View {
  
  //MARK: - Variables
  
  @ObservedObject var viewModel = VerifyViewModel(temporaryToken: "")
  @EnvironmentObject var appRootManager: AppRootManager
  
  //MARK: - View
  var body: some View {
    VStack {
      Text("Verify-MFA")
        .font(.system(size: 36.0).bold())
      Spacer()
      HStack {
        Spacer().frame(width: 10)
        HStack {
          Spacer().frame(width: 10)
          TextField("OTP", text: $viewModel.otp, onEditingChanged: { _ in
            
          })
          .frame(height: 50)
          .keyboardType(.numberPad)
          .autocapitalization(.none)
          
          
          Spacer().frame(width: 10)
        }.background(
          RoundedRectangle(cornerRadius: 25)
            .fill(Color(.secondarySystemBackground))
        )
        Spacer().frame(width: 10)
      }
      Spacer().frame(height: 10)
      HStack {
        Spacer()
        
        Button {
          Task {
            await viewModel.callResendOtpApi()
          }
        } label: {
          Text("Resend OTP")
        }
        .frame(height: 20)
        Spacer().frame(width: 15)
      }
      Spacer().frame(height: 20)
      
      Button {
        Task {
          await viewModel.callVerifyApi()
          if viewModel.verifyData != nil && viewModel.verifyData?.statusCode == nil {
            appRootManager.currentRoot = .mainView
            appRootManager.reset()
            DataManager.isUserLoggedIn = true
          }
        }
      } label: {
        Text("Submit")
      }
      .frame(height: 20)
      Spacer()
    }.alert("Error", isPresented: $viewModel.showAlert) {
      Button("OK", role: .cancel) { }
    } message: {
      Text(viewModel.errorMessage ?? "")
    }
  }
}

#Preview {
    VerifyView()
}
