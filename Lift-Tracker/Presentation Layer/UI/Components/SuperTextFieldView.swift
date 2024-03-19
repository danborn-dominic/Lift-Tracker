//
//  SuperTextFieldView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/18/24.
//

import SwiftUI

struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var textFieldPadding: CGFloat = 4 // Add padding variable to customize the inset
    
    var body: some View {
        ZStack (alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, textFieldPadding)
            }
            TextField("", text: $text)
                .padding(.leading, textFieldPadding)
        }
    }
    
}

struct SuperTextFieldV2: View {
    
    var placeholder: Text
    @Binding var text: String
    var textFieldPadding: CGFloat = 4 // Add padding variable to customize the inset
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack (alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .padding(.leading, textFieldPadding)
                }
                TextField("", text: $text)
                    .padding(.leading, textFieldPadding)
            }
            Spacer()
        }
    }
    
}

struct DropDownField: View {
    
    var body: some View {
        HStack(spacing: 45) {
            HStack(spacing: 10) {
                Text("Any")
                    .foregroundColor(Color.secondaryTextColor)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.secondaryTextColor)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 13, bottom: 12, trailing: 13))
        .frame(width: 165)
        .background(Color.componentColor)
        .cornerRadius(10)
        
    }
}
