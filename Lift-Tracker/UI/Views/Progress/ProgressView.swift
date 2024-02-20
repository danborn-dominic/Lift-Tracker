//
//  ProgressView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct ProgressView: View {
    
    private let container: DIContainer

    init(container: DIContainer) {
        print("INFO ProgressView init: DIContainer injected")
        self.container = container
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Progress")
                        .font(.largeTitle)
                        .bold()
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        Text("Progress content")
    }
}

#if DEBUG
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(container: .preview)
    }
}
#endif
