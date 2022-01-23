//
//  WelcomeSheetView.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetView: View {
    var pages: [WelcomeSheetPage]
    
    var body: some View {
        NavigationView {
            if let firstPage = pages.first {
                if #available(iOS 14.0, *) {
                    WelcomeSheetPageView(page: firstPage, restPages: pages.filter({ $0.id != firstPage.id }))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                } else {
                    WelcomeSheetPageView(page: firstPage, restPages: pages.filter({ $0.id != firstPage.id }))
                        .navigationBarTitle(Text(""), displayMode: .inline)
                        .navigationBarHidden(true)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
