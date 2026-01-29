//
//  FilterView.swift
//  FilterButton
//
//  Created by Yogesh on 1/28/26.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    
    @State private var customer = "Select"
    @State private var carrier = "Select"
    @State private var enteredBy = "Select"
    @State private var dispatcher = "Select"
    @State private var brokerageStatus = "Select"
    @State private var pickupDateStart = "From"
    @State private var pickupDateEnd = "To"
    @State private var deliveryDateStart = "From"
    @State private var deliveryDateEnd = "To"
    @State private var orderType = "Select"
    @State private var nextStopDateStart = "Select"
    @State private var nextStopDateEnd = "Select"
    @State private var isTSARequired = false
    
    @State private var activeDropdownId: String? = nil
    @State private var dropdownFrameData: DropdownFrameData?

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Filter")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        // Reset all values to default
                        customer = "Select"
                        carrier = "Select"
                        enteredBy = "Select"
                        dispatcher = "Select"
                        brokerageStatus = "Select"
                        pickupDateStart = "From"
                        pickupDateEnd = "To"
                        deliveryDateStart = "From"
                        deliveryDateEnd = "To"
                        orderType = "Select"
                        nextStopDateStart = "Select"
                        nextStopDateEnd = "Select"
                        isTSARequired = false
                        activeDropdownId = nil
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding()

                ScrollView {
                    VStack(spacing: 24) {
                        
                        FloatingLabelDropdown(label: "Customer (s)", selection: $customer, id: "customer", activeDropdownId: $activeDropdownId)
                        FloatingLabelDropdown(label: "Carrier (s)", selection: $carrier, id: "carrier", activeDropdownId: $activeDropdownId)
                        FloatingLabelDropdown(label: "Entered By", selection: $enteredBy, id: "enteredBy", activeDropdownId: $activeDropdownId)
                        FloatingLabelDropdown(label: "Dispatcher", selection: $dispatcher, id: "dispatcher", activeDropdownId: $activeDropdownId)
                        FloatingLabelDropdown(label: "Brokerage Status", selection: $brokerageStatus, id: "brokerageStatus", activeDropdownId: $activeDropdownId)
                        
                        DateRangePickerField(label: "Pickup Date", startDate: $pickupDateStart, endDate: $pickupDateEnd)
                        DateRangePickerField(label: "Delivery Date", startDate: $deliveryDateStart, endDate: $deliveryDateEnd)
                        
                        FloatingLabelDropdown(label: "Order Type", selection: $orderType, id: "orderType", activeDropdownId: $activeDropdownId)
                        
                        DateRangePickerField(label: "Next Stop Scheduled Early", startDate: $nextStopDateStart, endDate: $nextStopDateEnd)

                        ToggleRow(isOn: $isTSARequired, title: "TSA Required")
                    }
                    .padding()
                }
                
                // Footer - Apply Button
                VStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Apply")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(white: 0.3))
                            .cornerRadius(4)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
            }
            
            // Render dropdown at ZStack level to ensure it captures touches
            if let activeId = activeDropdownId {
                renderActiveDropdown(for: activeId)
            }
        }
        .coordinateSpace(name: "mainStack")
        .onPreferenceChange(DropdownFramePreferenceKey.self) { value in
            dropdownFrameData = value
        }
    }
    
    @ViewBuilder
    private func renderActiveDropdown(for id: String) -> some View {
        if let frameData = dropdownFrameData, frameData.id == id {
            let items = ["Apple", "Banana", "Orange", "Mango", "Grapes", "Pineapple"]
            let binding = getBinding(for: id)
            
            DropdownListView(
                items: items,
                selected: binding.wrappedValue,
                onSelect: { value in
                    binding.wrappedValue = value
                    withAnimation {
                        activeDropdownId = nil
                    }
                }
            )
            .frame(width: frameData.width)
            .position(
                x: frameData.frame.midX,
                y: frameData.direction == .down
                    ? frameData.frame.maxY + 80
                    : frameData.frame.minY - 80
            )
            .zIndex(3000)
        }
    }
    
    private func getBinding(for id: String) -> Binding<String> {
        switch id {
        case "customer": return $customer
        case "carrier": return $carrier
        case "enteredBy": return $enteredBy
        case "dispatcher": return $dispatcher
        case "brokerageStatus": return $brokerageStatus
        case "orderType": return $orderType
        default: return $customer
        }
    }
}
