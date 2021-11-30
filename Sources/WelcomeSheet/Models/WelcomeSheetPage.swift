//
//  WelcomeSheetPage.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// A type that describes a welcome sheet page's content.
public struct WelcomeSheetPage: Identifiable {
    public var id = UUID()
    
    
    /// Large title displayed on top.
    public var title: String
    /// Rows of content inside body.
    public var rows: [WelcomeSheetPageRow]
    
    
    /// Color used for buttons.
    public var accentColor: Color?
    
    
    /// Title for optional button
    public var optionalButtonTitle: String?
    /// Action for optional button
    public var optionalButtonAction: (() -> Void)?
    
    /// Creates welcome sheet page with given title and rows.
    public init(title: String, rows: [WelcomeSheetPageRow]) {
        self.title = title
        self.rows = rows
    }
    
    /// Creates welcome sheet page with given title and rows. Tints buttons with specified color.
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color) {
        self.init(title: title, rows: rows)
        self.accentColor = accentColor
    }
    
    /// Creates welcome sheet page with given title and rows. Sets optional button with entered title and action.
    public init(title: String, rows: [WelcomeSheetPageRow], optionalButtonTitle: String, optionalButtonAction: @escaping () -> Void) {
        self.init(title: title, rows: rows)
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonAction = optionalButtonAction
    }
    
    /// Creates welcome sheet page with given title and rows. Tints buttons with specified color. Sets optional button with entered title and action.
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color, optionalButtonTitle: String, optionalButtonAction: @escaping () -> Void) {
        self.init(title: title, rows: rows)
        self.accentColor = accentColor
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonAction = optionalButtonAction
    }
}
