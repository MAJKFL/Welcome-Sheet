//
//  ContentView.swift
//  Shared
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI
import WelcomeSheet

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    @State private var showSheet = false
    
    var pages: [WelcomeSheetPage] {
        [
        WelcomeSheetPage(title: "Welcome to Welcome Sheet", rows: [
            WelcomeSheetPageRow(imageSystemName: "note.text.badge.plus",
                                accentColor: Color.green,
                                title: "Quick Creation",
                                content: "Sheet creation is incredibly intuitive. Simply create an array of sheet pages filled with your content."),
            
            WelcomeSheetPageRow(imageSystemName: "rectangle.grid.2x2.fill",
                                accentColor: Color(red: 0.00, green: 0.70, blue: 1.00),
                                title: "Highly Customizable", content: "Set accent colors, add optional buttons, disable dismiss gestures, perform actions after button taps or sheet dismissal and more!"),
            
            WelcomeSheetPageRow(imageSystemName: "lightbulb.fill",
                                accentColor: Color.orange,
                                title: "Works out of the box",
                                content: "Don't worry about different screen sizes. Your Welcome Sheet will look gorgeous on every iOS device!")
        ], accentColor: Color.purple, optionalButtonTitle: "About Welcome Sheet...", optionalButtonAction: { openURL(URL(string: "https://github.com/MAJKFL/Welcome-Sheet")!) }),
        
        WelcomeSheetPage(title: "What's New in Translate", rows: [
            WelcomeSheetPageRow(imageSystemName: "platter.2.filled.iphone",
                                title: "Conversation Views",
                                content: "Choose a side-by-side or face-to-face conversation view."),
            
            WelcomeSheetPageRow(imageSystemName: "mic.badge.plus",
                                title: "Auto Translate",
                                content: "Respond in conversations without tapping the microphone button."),
            
            WelcomeSheetPageRow(imageSystemName: "iphone",
                                title: "System-Wide Translation",
                                content: "Translate selected text anywhere on your iPhone.")
        ], optionalButtonTitle: "About Translation & Privacy...", optionalButtonAction: { print("Tapped 'About Translation & Privacy...'") }),
        
        WelcomeSheetPage(title: "Welcome to Reminders", rows: [
            WelcomeSheetPageRow(imageSystemName: "note.text.badge.plus",
                                accentColor: Color.green,
                                title: "Quick Creation",
                                content: "Simply type, ask Siri, or use the quick toolbar to create reminders."),
            
            WelcomeSheetPageRow(imageSystemName: "rectangle.grid.2x2.fill",
                                accentColor: Color(red: 0.00, green: 0.70, blue: 1.00),
                                title: "Easy Organizing", content: "Create lists to match your needs and categorize reminders with tags. Collaborate with others by sharing lists and assigning individual tasks."),
            
            WelcomeSheetPageRow(imageSystemName: "lightbulb.fill",
                                accentColor: Color.orange,
                                title: "Suggestions and Smart Lists",
                                content: "Suggestions help you organize quickly, and smart lists automatically group reminders.")
        ], accentColor: Color.blue),
        
        WelcomeSheetPage(title: "What's New in Maps", rows: [
            WelcomeSheetPageRow(imageSystemName: "map.fill",
                                accentColor: Color.green,
                                title: "Updated Map Style",
                                content: "An improved design makes it easier to navigate and explore the map."),
            
            WelcomeSheetPageRow(imageSystemName: "mappin.and.ellipse",
                                accentColor: Color.red,
                                title: "All-New Place Cards",
                                content: "Completely redesigned place cards make it easier to learn about and interact with places."),
            
            WelcomeSheetPageRow(imageSystemName: "magnifyingglass",
                                accentColor: Color.blue,
                                title: "Improved Search",
                                content: "Finding places is now easier with filters and automatic updates when you're browsing results on the map.")
        ], accentColor: Color.blue, optionalButtonTitle: "About Apple Maps & Privacy...", optionalButtonAction: { print("Tapped 'About Apple Maps & Privacy...'") })
        ]
    }
    
    var body: some View {
        Button("Show sheet") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { showSheet.toggle() }
        }
        .padding()
        .welcomeSheet(isPresented: $showSheet, onDismiss: { print("Sheet dismissed") }, isSlideToDmismissDisabled: true, pages: pages)
    }
}
