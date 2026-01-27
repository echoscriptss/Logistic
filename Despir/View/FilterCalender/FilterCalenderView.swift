//import SwiftUI
import SwiftUI

// MARK: - Public Date Range Picker View
struct FilterCalenderView: View {

    // Returned values (owned by parent app)
    @Binding public var startDate: Date?
    @Binding public var endDate: Date?
    @Binding public var showCalendar: Bool

    @State private var currentMonth: Date = Date()

    private let calendar = Calendar.current
    @Binding public var isSingleDateSelection: Bool

    @State private var hourText: String = ""
    @State private var minuteText: String = ""

    @Binding public var showsTimePicker: Bool

    // Required public initializer for Swift Package
    public init(
        startDate: Binding<Date?>,
        endDate: Binding<Date?>,
        showCalendar: Binding<Bool>,
        isSingleDateSelection: Binding<Bool>,
        showsTimePicker: Binding<Bool>
    ) {
        self._startDate = startDate
        self._endDate = endDate
        self._showCalendar = showCalendar
        self._isSingleDateSelection = isSingleDateSelection
        self._showsTimePicker = showsTimePicker
    }

    public var body: some View {
        VStack(spacing: 16) {

//            Text("Select Date Range")
//                .font(.title2)
//                .fontWeight(.semibold)

            VStack(spacing: 8) {

                // Calendar appears BELOW the textfields
                if showCalendar {
                    calendarView
                    //    .transition(.opacity.combined(with: .move(edge: .top)))
                    //    .transition(.blurReplace)
                }
            }
        }
      //  .animation(.smooth, value: showCalendar)
    }
}

// MARK: - Calendar View
extension FilterCalenderView {
    
    private var calendarView: some View {
        VStack(spacing: 16) {

            // Month navigation
            HStack {
                Button {
                    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearString(from: currentMonth))
                    .font(.headline)

                Spacer()

                Button {
                    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Weekdays
            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) {
                    Text($0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }

            // Days grid
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7),
                spacing: 0
            ) {
                ForEach(daysInMonth(), id: \.self) { date in
                    DayCell(
                        date: date,
                        isStart: isSameDay(date, startDate),
                        isEnd: isSameDay(date, endDate),
                        isInRange: isMiddleDate(date),
                        hasCompleteRange: startDate != nil && endDate != nil
                    )
                    .onTapGesture {
                        handleSelection(date)
                    }
                }
            }

            if showsTimePicker {

                HStack(spacing: 16) {

                    VStack(alignment: .leading) {
                        Text("Hours")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("HH", text: $hourText)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .frame(width: 80)
                            .onChange(of: hourText) {_, newValue in
                                hourText = validateTimeInput(newValue, range: 0...23)
                            }
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Minutes")
                            .font(.caption)
                            .foregroundColor(.gray)

                        TextField("MM", text: $minuteText)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .frame(width: 80)
                            .onChange(of: minuteText) {_, newValue in
                                minuteText = validateTimeInput(newValue, range: 0...59)
                            }
                    }
                }
                .padding(.horizontal)
            }

            // Action buttons
            HStack {
                
                // Clear Button
                   Button {
                       startDate = nil
                       endDate = nil
                       hourText = ""
                       minuteText = ""
                   } label: {
                       Text("Clear dates")
                           .frame(maxWidth: .infinity)
                   }
                   .foregroundColor(.red)

                
                Button("Cancel") {
                    showCalendar = false
                }
                .frame(maxWidth: .infinity)

                Button("Apply") {
                    showCalendar = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

// MARK: - Day Cell
struct DayCell: View {

    let date: Date
    let isStart: Bool
    let isEnd: Bool
    let isInRange: Bool
    let hasCompleteRange: Bool

    var body: some View {
        ZStack {

            // 🔹 Range background ONLY if range is complete
            if hasCompleteRange {

                if isInRange {
                    Rectangle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(height: 32)
                }

                if isStart {
                    RoundedCorners(
                        radius: 16,
                        corners: [.topLeft, .bottomLeft]
                    )
                    .fill(Color.blue.opacity(0.25))
                    .frame(height: 32)
                    .padding(.leading, 5)
                }

                if isEnd {
                    RoundedCorners(
                        radius: 16,
                        corners: [.topRight, .bottomRight]
                    )
                    .fill(Color.blue.opacity(0.25))
                    .frame(height: 32)
                    .padding(.trailing, 5)
                }
            }

            // 🔵 Start circle (always visible)
            if isStart {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 32, height: 32)
            }

            // 🔵 End circle (navy)
            if isEnd {
                Circle()
                    .fill(Color(red: 0.0, green: 0.0, blue: 0.5))
                    .frame(width: 32, height: 32)
            }

            // Day number
            Text("\(Calendar.current.component(.day, from: date))")
                .foregroundColor(isStart || isEnd ? .white : .primary)
        }
        .frame(height: 40)
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = 16
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Helpers
extension FilterCalenderView {

    func dateBox(title: String, date: Date?) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(date != nil ? formatted(date!) : "--")
                .font(.headline)
        }
    }

    // First tap = start date, second = end date
    func handleSelection(_ date: Date) {
        // SINGLE DATE MODE
        if isSingleDateSelection {
            startDate = date
            endDate = nil
            return
        }
        
        if startDate == nil {
            startDate = date
            return
        }

        if endDate == nil {
            if date >= startDate! {
                endDate = date
            } else {
                startDate = date
            }
            return
        }

        // Third tap resets selection
        startDate = date
        endDate = nil
    }

    func daysInMonth() -> [Date] {
        guard
            let range = calendar.range(of: .day, in: .month, for: currentMonth),
            let monthStart = calendar.date(
                from: calendar.dateComponents([.year, .month], from: currentMonth)
            )
        else { return [] }

        return range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: monthStart)
        }
    }

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    func isSameDay(_ date1: Date, _ date2: Date?) -> Bool {
        guard let date2 else { return false }
        return calendar.isDate(date1, inSameDayAs: date2)
    }

//    func isMiddleDate(_ date: Date) -> Bool {
//        guard let start = startDate, let end = endDate else { return false }
//        return date > start && date < end
//    }
    
    func isMiddleDate(_ date: Date) -> Bool {
        guard !isSingleDateSelection else { return false }
        guard let start = startDate, let end = endDate else { return false }
        return date > start && date < end
    }
    
    func validateTimeInput(_ value: String, range: ClosedRange<Int>) -> String {
        let filtered = value.filter { $0.isNumber }

        guard let number = Int(filtered) else {
            return ""
        }

        let clamped = clamp(number, range: range)
        return String(format: "%02d", clamped)
    }

    func clamp(_ value: Int, range: ClosedRange<Int>) -> Int {
        min(Swift.max(value, range.lowerBound), range.upperBound)
    }
}
