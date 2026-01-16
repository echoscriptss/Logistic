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
 
  @FocusState private var focusedIndex: Int?
  
  //MARK: - View
  var body: some View {
    VStack {
      Text("Verify-MFA")
        .font(.system(size: 36.0).bold())
      Spacer()
      HStack {
        Spacer().frame(width: 15)
        ForEach(0..<6, id: \.self) { index in
          TextField("", text: Binding(
              get: { viewModel.otp[index] },
              set: { newValue in
                  processInput(newValue, index)
              }
          ))
          .keyboardType(.numberPad)
          .textContentType(index == 0 ? .oneTimeCode : .none)
          .multilineTextAlignment(.center)
          .frame(width: 45, height: 55)
          .background(
              RoundedRectangle(cornerRadius: 8)
                  .stroke(focusedIndex == index ? Color.blue : Color.gray)
          )
          .focused($focusedIndex, equals: index)
          if index != 5 {
            Spacer()
          }
        }
        
        Spacer().frame(width: 15)
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
    .onAppear {
      focusedIndex = 0
    }
  }
  private func processInput(_ value: String, _ index: Int) {

      let currentValue = viewModel.otp[index]

      // 🔥 Autofill / Paste
      if value.count == 6 {
          let digits = Array(value.prefix(6))
          for i in 0..<digits.count {
              viewModel.otp[i] = String(digits[i])
          }
        DispatchQueue.main.async {
          focusedIndex = nil
        }
         
          return
      }

      // 🔥 Single digit replace
      if let digit = value.last, digit.isNumber {

          // ✅ IMPORTANT: update only if different
          if currentValue != String(digit) {
              viewModel.otp[index] = String(digit)

              if index < 5 {
                  focusedIndex = index + 1
              } else {
                  focusedIndex = nil
              }
          }
          return
      }

      // 🔥 Backspace
      if value.isEmpty && !currentValue.isEmpty {
          viewModel.otp[index] = ""
          if index > 0 {
              focusedIndex = index - 1
          }
      }
  }
}

#Preview {
    VerifyView()
}
