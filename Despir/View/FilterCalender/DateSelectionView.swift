//
//  DateSelectionView.swift
//  Despir
//
//  Created by Nitin on 23/01/26.
//

import SwiftUI

struct DateSelectionView: View {
    // MARK: - State Properties
    @State private var showCalendar = false
    @State private var startDate: Date?
    @State private var endDate: Date?
    @State private var isSingleDateSelection = false
    @State private var showsTimePicker = true

    // Geometry States to track positions
    @State private var buttonFrame: CGRect = .zero
    @State private var calendarHeight: CGFloat = 0 // Will be calculated dynamically

    var body: some View {
        // Alignment .topLeading is crucial for coordinate calculations (0,0 at top-left)
        ZStack(alignment: .topLeading) {
            
            // MARK: - 1. Main Scrollable Content
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack {
                        // Dummy content to demonstrate scrolling
                        Spacer().frame(height: 470)
                        Text("Scroll down to find the button...")
                            .foregroundColor(.gray)
                        
                        // MARK: Date Trigger Button
                        Button {
                        //    withAnimation(.easeInOut(duration: 0.2)) {
                                showCalendar.toggle()
                       //     }
                        } label: {
                            HStack {
                                Text(dateRangeText)
                                    .foregroundColor(startDate == nil ? .gray : .primary)
                                Spacer()
                                Image(systemName: "calendar")
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                        }
                        // Capture the button's position on screen
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(
                                    key: ButtonFrameKey.self,
                                    value: geo.frame(in: .global)
                                )
                            }
                        )
                        .padding(.horizontal)
                        .id("dateButton") // ID for programmatic scrolling if needed

                        // Dummy content below
                        Spacer().frame(height: 1000)
                    }
                }
                // Update buttonFrame state whenever the button moves (e.g. scrolling)
                .onPreferenceChange(ButtonFrameKey.self) { frame in
                    self.buttonFrame = frame
                }
            }

            // MARK: - 2. Calendar Overlay
            if showCalendar {
                // Dimmed background to detect taps outside the calendar
                Color.black.opacity(0.01)
                    .ignoresSafeArea()
                    .onTapGesture {
                    //    withAnimation {
                            showCalendar = false
                   //     }
                    }

                // The Calendar View
                FilterCalenderView(
                    startDate: $startDate,
                    endDate: $endDate,
                    showCalendar: $showCalendar,
                    isSingleDateSelection: $isSingleDateSelection,
                    showsTimePicker: $showsTimePicker
                )
                // Measure the actual height of the calendar content
                .background(
                    GeometryReader { geo -> Color in
                        DispatchQueue.main.async {
                            // Only update if size changed to prevent loops
                            if self.calendarHeight != geo.size.height {
                                self.calendarHeight = geo.size.height
                            }
                        }
                        return Color.clear
                    }
                )
                .frame(width: 350) // Fixed width for the dropdown
                // Force the view to position exactly where we calculate
                .position(
                    x: buttonFrame.midX, // Center horizontally on the button
                    y: calculateAdjacencyY()  // Calculate Y based on space
                )
               // .transition(.blurReplace)
                .zIndex(1) // Ensure it floats above everything else
            }
        }
    }

    // MARK: - Logic Helpers

    /// Calculates the exact Y position for the center of the calendar
    private func calculateAdjacencyY() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let spacing: CGFloat = 8 // Gap between button and calendar
        
        // We need the center position for .position(), so we use half height
        let halfCalendarHeight = calendarHeight / 2
        
        // Calculate available space below the button
        let spaceBelow = screenHeight - buttonFrame.maxY
        
        // Decision: If space below is less than calendar height, flip UP.
        // Otherwise, default to DOWN.
        if spaceBelow < calendarHeight {
            // SHOW ABOVE
            // Math: Button Top - Spacing - Half Height
            return buttonFrame.minY - spacing - halfCalendarHeight - 54
        } else {
            // SHOW BELOW
            // Math: Button Bottom + Spacing + Half Height
            return buttonFrame.maxY + spacing + halfCalendarHeight - 69
        }
    }

    private var dateRangeText: String {
        if let s = startDate, let e = endDate {
            return "\(format(s)) - \(format(e))"
        } else if let s = startDate {
            return format(s)
        } else {
            return "Select date range"
        }
    }

    private func format(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy"
        return f.string(from: date)
    }
}

// MARK: - Preference Key to Track Position
struct ButtonFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - Preview
struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
