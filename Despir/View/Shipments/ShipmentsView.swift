//
//  ShipmentsView.swift
//  Despir
//
//  Created by Prabhjot Singh on 27/01/26.
//

import SwiftUI

struct ShipmentsView: View {
    @State private var showFilter = false

    var body: some View {
        ZStack{
        VStack {
            CustomNavigationBar(title: "Shipments", showBack: false, showLogo: true)
            Spacer().frame(height: 10)
            HStack {
                Spacer()
                Button(action: {
                    showFilter = true
                    
                }) {
                    Image(AppIcons.filter)
                }
                Spacer().frame(width: 10)
            }
            Spacer()
        }
    }
        .sheet(isPresented: $showFilter) {
            FilterView(isPresented: $showFilter)
        }
    }
}

#Preview {
    ShipmentsView()
}
