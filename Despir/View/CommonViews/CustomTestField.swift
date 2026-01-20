//
//  CustomTestField.swift
//  Despir
//
//  Created by Prabhjot Singh on 19/01/26.
//

import SwiftUI

struct CustomTestField: View {

    let title: String
    let icon: String

    @Binding var text: String
    @Binding var isValid: Bool
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {

            // Border
            RoundedRectangle(cornerRadius: 10)
                .stroke(isValid ? Color.gray.opacity(0.6) : Color.red, lineWidth: 1)
                .frame(height: 56)

            // Floating Placeholder
          HStack {
            Spacer().frame(width: isFocused || !text.isEmpty ? 18 : 40)
            Text(title)
              .foregroundColor(isFocused || !text.isEmpty ? .black.opacity(0.6) : .black.opacity(0.6))
              .font(isFocused || !text.isEmpty ? .body : .body)
              .background(Color(.systemBackground))
              .offset(y: isFocused || !text.isEmpty ? -28 : 0)
              .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
          }
            // Icon + TextField
            HStack {
                Image(icon)
                    .padding(.leading, 15)

                TextField("", text: $text)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .focused($isFocused)

            }
        }
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
  CustomTestField(title: "", icon: "", text: .constant(""), isValid: .constant(true))
}


struct CustomSecureTestField: View {

    let title: String
    let icon: String

    @Binding var text: String
    @Binding var isValid: Bool
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
  
    var body: some View {
        ZStack(alignment: .leading) {

            // Border
            RoundedRectangle(cornerRadius: 10)
                .stroke(isValid ? Color.gray.opacity(0.6) : Color.red, lineWidth: 1)
                .frame(height: 56)

            // Floating Placeholder
          HStack {
            Spacer().frame(width: isFocused || !text.isEmpty ? 18 : 40)
            Text(title)
              .foregroundColor(isFocused || !text.isEmpty ? .black.opacity(0.6) : .black.opacity(0.6))
              .font(isFocused || !text.isEmpty ? .body : .body)
              .background(Color(.systemBackground))
              .offset(y: isFocused || !text.isEmpty ? -28 : 0)
              .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
          }
            // Icon + TextField
            HStack {
                Image(icon)
                    .padding(.leading, 15)
              if isSecure {
                SecureField("", text: $text)
                  .keyboardType(.emailAddress)
                  .textInputAutocapitalization(.never)
                  .autocorrectionDisabled(true)
                  .focused($isFocused)

              } else {
                TextField("", text: $text)
                  .keyboardType(.emailAddress)
                  .textInputAutocapitalization(.never)
                  .autocorrectionDisabled(true)
                  .focused($isFocused)

              }
              HStack {
                Spacer().frame(width: 12)
                Button {
                  isSecure = !isSecure
                } label: {
                  Image(isSecure ? AppIcons.eye: AppIcons.eye)
                }
                Spacer().frame(width: 12)
              }
            }
        }
        .onTapGesture {
            isFocused = true
        }
    }
}
