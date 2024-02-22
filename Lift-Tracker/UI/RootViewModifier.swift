//
//  RootViewModifier.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/27/23.
//
//  Description:
//  This file contains the RootViewAppearance struct, a custom view modifier used to apply global styling
//  and configuration to the root view of the Lift-Tracker application. It utilizes the DIContainer from the
//  environment to access shared application dependencies.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

/// A view modifier that applies global appearance settings to the root view.
struct RootViewAppearance: ViewModifier {
    
    @Environment(\.injected) private var injected: DIContainer
    
    /// Modifies the provided content according to this modifier's logic.
    /// - Parameters:
    ///    - content: The content of the view that uses this modifier.
    /// - Returns:
    ///     - A modified view with the applied appearance settings.
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea()              // Ensures the content extends to the entire screen, ignoring safe area insets.
    }
}
