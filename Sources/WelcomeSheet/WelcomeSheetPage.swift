//
//  File.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

public struct WelcomeSheetPage: Identifiable {
    public var id = UUID()
    public var title: String
    public var rows: [WelcomeSheetPageRow]
    public var accentColor: Color?
    public var optionalButtonTitle: String?
    public var optionalButtonAction: (() -> Void)?
    
    public init(title: String, rows: [WelcomeSheetPageRow]) {
        self.title = title
        self.rows = rows
    }
    
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color) {
        self.title = title
        self.rows = rows
        self.accentColor = accentColor
    }
    
    public init(title: String, rows: [WelcomeSheetPageRow], optionalButtonTitle: String, optionalButtonAction: @escaping () -> Void) {
        self.title = title
        self.rows = rows
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonAction = optionalButtonAction
    }
    
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color, optionalButtonTitle: String, optionalButtonAction: @escaping () -> Void) {
        self.title = title
        self.rows = rows
        self.accentColor = accentColor
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonAction = optionalButtonAction
    }
}
