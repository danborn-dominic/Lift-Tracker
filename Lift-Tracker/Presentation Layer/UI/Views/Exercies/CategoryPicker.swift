//
//  CategoryPicker.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/20/24.
//

import SwiftUI

struct CategoryPickerOverlay: View {
    @Binding var isPresented: Bool
    @Binding var selectedCategory: String
    var categories: [String]
    
    var body: some View {
        HStack(alignment: .top, spacing: 45) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .lineSpacing(22)
                        .foregroundColor(selectedCategory == category ? Color.accentColorBlue : Color.secondaryTextColor)
                        .padding(.leading, -40)
                        .onTapGesture {
                            selectedCategory = category
                            isPresented = false
                        }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
        .frame(width: 160, height: 200)
        .background(Color.componentColor)
        .cornerRadius(8)
    }
}
