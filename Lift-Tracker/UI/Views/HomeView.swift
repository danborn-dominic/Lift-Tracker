//
//  HomeView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // The actual content of your HomeView goes here.
        // NavigationView has been removed.
        Text("Home Content")
            .navigationBarTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
