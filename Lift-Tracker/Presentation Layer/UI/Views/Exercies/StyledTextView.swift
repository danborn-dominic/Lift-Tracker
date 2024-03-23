//
//  StyledTextView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/22/24.
//

import SwiftUI

struct StyledTextField: View {
    
    var labelText: String
    var placeholder: Text
    @Binding var text: String
    var width: CGFloat
    var height: CGFloat
    var labelPadding: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(labelText)
                    .foregroundColor(Color.secondaryTextColor)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: labelPadding, trailing: 0))
                    .font(.system(size: 12))
                Spacer()
            }
            ZStack {
                Rectangle()
                    .fill(Color.componentColor)
                    .frame(width: width, height: height)
                    .cornerRadius(8)
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        placeholder
                            .foregroundColor(Color.secondaryTextColor)
                            .padding(.leading, 35)
                    }
                    TextField("", text: $text)
                        .foregroundColor(Color.secondaryTextColor)
                        .padding(.leading, 35)
                }
            }
        }
    }
}

struct StyledTextFieldWithTextTopLeft: View {
    
    var labelText: String
    var placeholder: Text
    @Binding var text: String
    var width: CGFloat
    var height: CGFloat
    var labelPadding: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(labelText)
                    .foregroundColor(Color.secondaryTextColor)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: labelPadding, trailing: 0))
                    .font(.system(size: 12))
                Spacer()
            }
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.componentColor)
                    .frame(width: width, height: height)
                    .cornerRadius(8)
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        placeholder
                            .foregroundColor(Color.secondaryTextColor)
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 10))
                            .frame(width: width, height: height, alignment: .topLeading)
                    }
                    TextField("", text: $text)
                        .foregroundColor(Color.primaryTextColor)
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 10))
                        .frame(width: width, height: height, alignment: .topLeading)
                }
            }
        }
    }
}



// Rest of your StyledTextView struct code

#if DEBUG
struct StyledTextView_Previews: PreviewProvider {
    @State static var previewText: String = ""
    
    static var previews: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 10) {
                StyledTextField(labelText: "Exercise Name", placeholder: Text("Unnamed Exercise").foregroundColor(Color.secondaryTextColor), text: $previewText, width: 356, height: 40, labelPadding: -2)
                
                StyledTextFieldWithTextTopLeft(labelText: "Notes", placeholder: Text("D D D D D D D D D D D D D D D D D D D D D D D D D D"), text: $previewText, width: 356, height: 140, labelPadding: -2)
            }
        }
    }
}
#endif
