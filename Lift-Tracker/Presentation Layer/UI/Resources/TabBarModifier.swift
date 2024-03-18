//
//  TabBarModifier.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/18/24.
//

import SwiftUI

struct TabBarAppearanceModifier: ViewModifier {
    var selectedColor: UIColor
    var unselectedColor: UIColor

    init(selectedColor: Color, unselectedColor: Color) {
        self.selectedColor = UIColor(selectedColor)
        self.unselectedColor = UIColor(unselectedColor)

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.black

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(selectedColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(selectedColor)]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(unselectedColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(unselectedColor)]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    func body(content: Content) -> some View {
        content
    }
}
