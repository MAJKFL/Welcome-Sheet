//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetView: View {
    var pages: [WelcomeSheetPage]

    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                WelcomeSheetPageView(page: pages[0])
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                WelcomeSheetPageView(page: pages[0])
                    .navigationBarTitle(Text(""), displayMode: .inline)
            }
        }
    }
}
