//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

struct WelcomeSheetPageView: View {
    let welcomeSheetPage: WelcomeSheetPage

    var body: some View {
        VStack {
            Text(welcomeSheetPage.title)
                .padding()

            VStack {
                ForEach(welcomeSheetPage.rows) { row in
                    Text(row.title)
                }
            }

            if let optionalButtonTitle = welcomeSheetPage.optionalButtonTitle {
                Button {
                    if let optionalButtonAction = welcomeSheetPage.optionalButtonAction {
                        optionalButtonAction()
                    }
                } label: {
                    Text(optionalButtonTitle)
                }
            }

            Button {

            } label: {
                Text("Continue")
            }
        }
        .padding()
    }
}
