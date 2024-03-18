//
//  TabBarModifier.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/18/24.
//

import SwiftUI

struct TabBarAppearanceModifier: ViewModifier {
    init(color: UIColor) {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = color

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}
