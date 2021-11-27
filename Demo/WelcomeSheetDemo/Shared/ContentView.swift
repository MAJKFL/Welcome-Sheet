//
//  ContentView.swift
//  Shared
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI
import WelcomeSheet

struct ContentView: View {
    @State private var showSheet = false
    
    let pages = [
        WelcomeSheetPage(title: "Bajo jajo", rows: [
            WelcomeSheetPageRow(imageSystemName: "swift", title: "Bajo jajo", content: "Baj jajalsdjflksajflkasjdflkasjdfl"),
            WelcomeSheetPageRow(imageSystemName: "swift", title: "Bajo jajo", content: "Baj jajalsdjflksajflkasjdflkasjdfl"),
            WelcomeSheetPageRow(imageSystemName: "swift", title: "Bajo jajo", content: "Baj jajalsdjflksajflkasjdflkasjdfl")
        ])
    ]
    
    var body: some View {
        Button("Show sheet") {
            showSheet.toggle()
        }
        .padding()
        .welcomeSheet(isPresented: $showSheet, pages: pages)
    }
}
