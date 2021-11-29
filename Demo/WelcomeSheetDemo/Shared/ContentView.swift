//
//  ContentView.swift
//  Shared
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI
import WelcomeSheet

struct ContentView: View {
    @State private var showSheet = true
    
    let pages = [
        WelcomeSheetPage(title: "What's New in Translate", rows: [
            WelcomeSheetPageRow(imageSystemName: "platter.2.filled.iphone", title: "Conversation Views", content: "Choose a side-by-side or face-to-face conversation view."),
            WelcomeSheetPageRow(imageSystemName: "mic.badge.plus", title: "Auto Translate", content: "Respond in conversations without tapping the microphone button."),
            WelcomeSheetPageRow(imageSystemName: "iphone", title: "System-Wide Translation", content: "Translate selected text anywhere on your iPhone.")
        ], optionalButtonTitle: "About Translation & Privacy...", optionalButtonAction: { print("About Translation & Privacy...") })
    ]
    
    var body: some View {
        Button("Show sheet") {
            showSheet.toggle()
        }
        .padding()
        .welcomeSheet(isPresented: $showSheet, onDismiss: { print("bajbjj oaj") }, isSlideToDmismissDisabled: false, pages: pages)
    }
}
