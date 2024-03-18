//
//  SettingsView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primaryTextColor)
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        Text("Settings view content")
            .foregroundColor(.secondaryTextColor)
    }
}
