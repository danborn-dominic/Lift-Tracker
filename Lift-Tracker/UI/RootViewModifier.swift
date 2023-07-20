//
//  RootViewModifier.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/27/23.
//

import Foundation
import SwiftUI
import Combine

struct RootViewAppearance: ViewModifier {
    
    @Environment(\.injected) private var injected: DIContainer
    
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea()
    }
    
}
