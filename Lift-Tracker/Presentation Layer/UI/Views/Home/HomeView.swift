//
//  HomeView.swift
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

struct HomeView: View {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primaryTextColor)
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        Text("Home content")
            .foregroundColor(.secondaryTextColor)
    }
}

// MARK: - Preview

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(container: .preview)
    }
}
#endif
