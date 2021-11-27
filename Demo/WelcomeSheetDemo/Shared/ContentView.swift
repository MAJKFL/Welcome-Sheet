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
    
    var body: some View {
        Button("Show sheet") {
            showSheet.toggle()
        }
        .padding()
        .welcomeSheet(isPresented: $showSheet)
    }
}
