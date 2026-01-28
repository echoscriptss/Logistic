//
//  SelectionList.swift
//  FilterButton
//
//  Created by Yogesh on 1/27/26.
//
import SwiftUI

struct DropdownListView: View {
    let items: [String]
    let selected: String
    let onSelect: (String) -> Void

    @State private var searchText = ""

    private var filteredItems: [String] {
        searchText.isEmpty
        ? items
        : items.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            TextField("Search...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            Divider()
            ScrollView {
                VStack(spacing: 0) {
                    if filteredItems.isEmpty {
                        Text("No items found")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(filteredItems, id: \.self) { item in
                            Button {
                                onSelect(item)
                            } label: {
                                HStack {
                                    Text(item)
                                        .foregroundColor(.primary)
                                    Spacer()

                                    if item == selected {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding()
                                .contentShape(Rectangle()) // entire row clickable
                            }
                            .buttonStyle(.plain)

                            Divider()
                        }
                    }
                }
            }
            .frame(height: 200)
        }
        .allowsHitTesting(true)  // Explicitly enable touch handling
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)

        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 2.5)
        )
        .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
    }
}
