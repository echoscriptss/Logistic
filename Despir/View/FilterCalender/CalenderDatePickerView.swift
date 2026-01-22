//
//  DateRangeFieldsView.swift
//  MaySwiftUIDemo
//
//  Created by Nitin on 20/01/26.
//
import SwiftUI
//import DateRangePickerKit

public struct CalenderDatePickerView: View {

    @Binding public var startDate: Date?
    @Binding public var endDate: Date?
    @Binding public var showCalendar: Bool
    @Binding var isSingleDateSelection: Bool

    public init(
        startDate: Binding<Date?>,
        endDate: Binding<Date?>,
        showCalendar: Binding<Bool>,
        isSingleDateSelection: Binding<Bool>
    ) {
        self._startDate = startDate
        self._endDate = endDate
        self._showCalendar = showCalendar
        self._isSingleDateSelection = isSingleDateSelection
    }

    public var body: some View {
        HStack {

            Button {
                showCalendar = true
            } label: {
                DateBoxView(title: "Start Date", date: startDate)
            }
            .buttonStyle(.plain)

            Spacer()

            Button {
                showCalendar = true
            } label: {
                DateBoxView(title: "End Date", date: endDate)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}


    
struct DateBoxView: View {
    let title: String
    let date: Date?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(dateText)
                .font(.headline)
        }
    }

    private var dateText: String {
        guard let date else { return "--" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
