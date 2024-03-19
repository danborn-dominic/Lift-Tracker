//
//  BodyPartPicker.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/19/24.
//

import SwiftUI

struct BodyPartPickerOverlay: View {
    @Binding var isPresented: Bool
    @Binding var selectedBodyPart: String?
    var bodyParts: [String]
    
    var body: some View {
        HStack(alignment: .top, spacing: 45) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(bodyParts, id: \.self) { bodyPart in
                    Text(bodyPart)
                        .lineSpacing(22)
                        .foregroundColor(selectedBodyPart == bodyPart ? Color.accentColorBlue : Color.secondaryTextColor)
                        .padding(.leading, -40)
                        .onTapGesture {
                            selectedBodyPart = bodyPart
                        }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding(EdgeInsets(top: 9, leading: 13, bottom: 9, trailing: 13))
        .frame(width: 160, height: 377)
        .background(Color.componentColor)
        .cornerRadius(8)
    }
}
