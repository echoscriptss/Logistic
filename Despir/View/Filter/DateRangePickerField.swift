//
//  DateRangePickerField.swift
//  FilterButton
//
//  Created by Yogesh on 1/22/26.
//
import SwiftUI

struct DateRangePickerField: View {
    let label: String
    @Binding var startDate: String
    @Binding var endDate: String
    
    var body: some View {
        HStack {
            Text("\(startDate)  |  \(endDate)")
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "calendar")
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .overlay(
            GeometryReader { _ in
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                    .background(Color(UIColor.systemBackground))
                    .offset(x: 12, y: -8)
            }
        )
    }
}
