//
//  StyledDropdownButton.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/20/24.
//

import SwiftUI

struct StyledDropdownButton: View {
    
    var labelText: String
    var displayText: String
    var labelPadding: CGFloat
    var action: () -> Void // Add an action closure

    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(labelText)
                    .foregroundColor(Color.secondaryTextColor)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: labelPadding, trailing: 0))
                    .font(.system(size: 12))
                Spacer()
            }
            HStack(spacing: 10) {
                Text(displayText)
                    .foregroundColor(Color.secondaryTextColor)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.secondaryTextColor)
            }
            .padding(EdgeInsets(top: 12, leading: 13, bottom: 12, trailing: 13))
            .frame(width: 165, height: 40) // Ensure you set a height as well
            .background(Color.componentColor)
            .cornerRadius(10)
            .onTapGesture {
                self.action() // Call the action on tap
            }
        }
        
    }
}

#Preview {
    ZStack {
        Color.backgroundColor.ignoresSafeArea(.all)
        
        StyledDropdownButton(labelText: "Body Part", displayText: "Any", labelPadding: -2) {
            print("idk")
        }
    }
}
