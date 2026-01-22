//
//  DateRangeHostView.swift
//  MaySwiftUIDemo
//
//  Created by NITIN KUMAR KANOJIA on 20/01/26.
//

enum ActiveField {
    case start, end
}

import SwiftUI

//#Preview {
//    DateRangeHostView()
//}


import SwiftUI
//import DateRangePickerKit

struct FilterCalnderHostView: View {

    @EnvironmentObject var appRootManager: AppRootManager
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var showCalendar = false
    @State private var isSingleDateSelection = false
    @State private var showsTimePicker = false

    var body: some View {
        VStack(spacing: 12) {

            Button("Back") {
                appRootManager.currentRoot = .mainView
            }
            // 🔹 Fields
            CalenderDatePickerView(
                startDate: $startDate,
                endDate: $endDate,
                showCalendar: $showCalendar, isSingleDateSelection: $isSingleDateSelection
            )

            // 🔹 Calendar (BELOW fields)
            if showCalendar {
                FilterCalenderView(
                    startDate: $startDate,
                    endDate: $endDate,
                    showCalendar: $showCalendar, isSingleDateSelection:  $isSingleDateSelection, showsTimePicker: $showsTimePicker
                )
                //.transition(.move(edge: .top).combined(with: .opacity))
                .transition(.blurReplace)
            }

            Spacer()
        }
        .animation(.easeInOut, value: showCalendar)
        .padding()
    }
}
