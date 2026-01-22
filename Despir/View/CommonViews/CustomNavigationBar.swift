//
//  CustomNavigationBar.swift
//  Despir
//
//  Created by Prabhjot Singh on 22/01/26.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let title: String
    var showBack: Bool = true
    var onBack: (() -> Void)? = nil
    var rightView: AnyView? = nil

    var body: some View {
        HStack {
            
            // Back Button
            if showBack {
                Button(action: {
                    onBack?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
            } else {
                Spacer().frame(width: 24)
            }

            Spacer()

            // Title
            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            // Right Action
            if let rightView {
                rightView
            } else {
                Spacer().frame(width: 24)
            }
        }
        .padding()
        .frame(height: 56)
        .background(Color.white)
        .overlay(
            Divider(), alignment: .bottom
        )
    }
}
#Preview {
  CustomNavigationBar(title: "Shipments")
}
