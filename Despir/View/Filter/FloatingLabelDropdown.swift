//
//  FloatingLabelDropdown.swift
//  FilterButton
//
//  Created by Yogesh on 1/22/26.
//
import SwiftUI

enum DropdownDirection {
    case up
    case down
}

struct FloatingLabelDropdown: View {
    let label: String
    @Binding var selection: String
    var items: [String] = ["Apple", "Banana", "Orange", "Mango", "Grapes", "Pineapple"] // Pass Actual values here
    
    // New Props for Exclusive State
    let id: String
    @Binding var activeDropdownId: String?
    
    // Computed open state
    var isOpen: Bool {
        activeDropdownId == id
    }
    
    @State private var dropdownDirection: DropdownDirection = .down
    @State private var labelFrame: CGRect = .zero
    @State private var globalLabelFrame: CGRect = .zero
    @State private var dropdownHeight: CGFloat = 0

    var body: some View {
        HStack {
            Text(selection)
                .foregroundColor(selection == "Select" ? .gray : .primary)
            Spacer()
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(isOpen ? 180 : 0))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .overlay(
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 4)
                .background(Color(UIColor.systemBackground))
                .offset(x: 12, y: -10), // offset to sit on border
            alignment: .topLeading
        )
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        updateFrames(geo: geo)
                    }
                    .onChange(of: geo.frame(in: .named("mainStack"))) { oldValue, newValue in
                        updateFrames(geo: geo)
                    }
                    .onChange(of: geo.frame(in: .global)) { oldValue, newValue in
                        updateFrames(geo: geo)
                    }
            }
        )
        .contentShape(Rectangle())
        .onTapGesture {
            calculateDirection()
            withAnimation {
                if isOpen {
                    activeDropdownId = nil
                } else {
                    activeDropdownId = id
                }
            }
        }
        .preference(
            key: DropdownFramePreferenceKey.self,
            value: isOpen ? DropdownFrameData(
                id: id,
                frame: globalLabelFrame,
                width: labelFrame.width,
                direction: dropdownDirection
            ) : nil
        )
        .zIndex(isOpen ? 2000 : 0)
    }
    
    private func updateFrames(geo: GeometryProxy) {
        labelFrame = geo.frame(in: .named("mainStack"))
        globalLabelFrame = geo.frame(in: .global)
    }

    private func calculateDirection() {
        let screenHeight = UIScreen.main.bounds.height
        let spaceBelow = screenHeight - globalLabelFrame.maxY
        let estimatedDropdownHeight: CGFloat = 300 // increased threshold to favor opening up
        
        dropdownDirection = spaceBelow < estimatedDropdownHeight ? .up : .down
    }
}

struct DropdownFrameData: Equatable {
    let id: String
    let frame: CGRect
    let width: CGFloat
    let direction: DropdownDirection
}

struct DropdownFramePreferenceKey: PreferenceKey {
    static var defaultValue: DropdownFrameData?
    
    static func reduce(value: inout DropdownFrameData?, nextValue: () -> DropdownFrameData?) {
        value = nextValue() ?? value
    }
}

struct ToggleRow: View {
    @Binding var isOn: Bool
    let title: String
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isOn)
                .labelsHidden()
            Text(title)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

