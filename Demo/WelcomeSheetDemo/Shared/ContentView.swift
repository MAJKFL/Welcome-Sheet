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
        WelcomeSheetPage(title: "Welcome to Welcome Sheet", rows: [
            WelcomeSheetPageRow(imageSystemName: "rectangle.stack.fill.badge.plus",
                                accentColor: Color.mint,
                                title: "Quick Creation",
                                content: "It's incredibly intuitive. Simply declare an array of pages filled with content."),
            
            WelcomeSheetPageRow(imageNamed: "gears",
                                accentColor: Color.indigo,
                                title: "Highly Customisable", content: "Match sheet's appearance to your app, link buttons, perform actions after dismissal."),
            
            WelcomeSheetPageRow(imageSystemName: "ipad.and.iphone",
                                accentColor: Color.green,
                                title: "Works out of the box",
                                content: "Don't worry about various screen sizes. It will look gorgeous on every iOS device.")
        ], accentColor: Color.purple, optionalButtonTitle: "About Welcome Sheet...", optionalButtonURL: URL(string: "https://github.com/MAJKFL/Welcome-Sheet")),
        
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
        ], mainButtonTitle: "Wassup?"),
        
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
        ], accentColor: Color.pink, mainButtonTitle: "Let's go!", optionalButtonTitle: "About Apple Maps & Privacy...", optionalButtonURL: URL(string: "https://apple.com"))
    ]
    
    var body: some View {
        Button("Show sheet") {
            showSheet.toggle()
        }
        .padding()
        .welcomeSheet(isPresented: $showSheet, onDismiss: { sheetDismissed() }, isSlideToDismissDisabled: true, pages: pages) // Sheet from page array
//        .welcomeSheet(isPresented: $showSheet, onDismiss: { sheetDismissed() }, isSlideToDismissDisabled: true, pages: getPagesFromJSON()) // Sheet from JSON
    }
    
    func sheetDismissed() {
        print("Sheet dismissed")
    }
    
    func getPagesFromJSON() -> [WelcomeSheetPage] {
        if let url = Bundle.main.url(forResource: "demo", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode([WelcomeSheetPage].self, from: jsonData)
            } catch {
                print(error)
            }
        }
        return []
    }
}
