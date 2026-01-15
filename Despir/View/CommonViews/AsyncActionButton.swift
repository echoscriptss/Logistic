//
//  AsyncActionButton.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//
import SwiftUI

struct AsyncActionButton<Label: View>: View {
    let action: () async -> Void
    let label: () -> Label

    @State private var isLoading = false

    var body: some View {
        Button {
            Task {
                isLoading = true
                await action()
                isLoading = false
            }
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                } else {
                    label()
                }
            }
        }
        .disabled(isLoading)
    }
}
