//
//  AddExerciseView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/5/24.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI

struct AddExerciseView: View {
    private let container: DIContainer
    @Environment(\.presentationMode) var presentationMode
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        self.content
    }
    
    @ViewBuilder private var content: some View {
        
        NavigationView {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                Form {
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hides the default back button
        .navigationBarItems(leading: backButton) // Adds your custom back button
        
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left") // The SFSymbol for the back arrow
                    .foregroundColor(.accentColor) // Here you can set the color you want
                Text("Exercises") // Your custom text
                    .foregroundColor(.accentColor) // And the color
            }
        }
    }
}
