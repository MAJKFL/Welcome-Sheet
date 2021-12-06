//
//  WelcomeSheetPage.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// A type that describes welcome sheet page's content.
public struct WelcomeSheetPage: Identifiable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case title
        case rows
        case mainButtonTitle
        case accentColor
        case isShowingOptionalButton
        case optionalButtonTitle
        case optionalButtonURL
        case backgroundColor
    }
    
    public var id = UUID()
    
    
    /// Large title displayed on the top.
    public var title: String
    /// Rows of content inside a body.
    public var rows: [WelcomeSheetPageRow]
    
    
    /// Title for a main button. Set to "Continue" by default.
    public var mainButtonTitle: String
    /// Color used for buttons. When set to nil, uses default accent colour.
    public var accentColor: Color?
    
    
    /// Specifies whether to show an optional button.
    public var isShowingOptionalButton = false
    /// Title for an optional button.
    public var optionalButtonTitle: String?
    /// URL to open when an optional button is pressed.
    public var optionalButtonURL: URL?
    
    
    /// Creates welcome sheet page with given title, rows and main button title.
    public init(title: String, rows: [WelcomeSheetPageRow], mainButtonTitle: String? = nil) {
        self.title = title
        self.rows = rows
        self.mainButtonTitle = mainButtonTitle ?? "Continue"
    }
    
    /// Creates welcome sheet page with given title, rows and main button title. Tints buttons with specified colour.
    public init(title: String, rows: [WelcomeSheetPageRow], mainButtonTitle: String? = nil, accentColor: Color) {
        self.init(title: title, rows: rows, mainButtonTitle: mainButtonTitle)
        self.accentColor = accentColor
    }
    
    /// Creates welcome sheet page with given title, rows and main button title. Sets optional button with entered title and URL to open.
    public init(title: String, rows: [WelcomeSheetPageRow], mainButtonTitle: String? = nil, optionalButtonTitle: String, optionalButtonURL: URL?) {
        self.init(title: title, rows: rows, mainButtonTitle: mainButtonTitle)
        self.isShowingOptionalButton = true
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonURL = optionalButtonURL
    }
    
    /// Creates welcome sheet page with given title, rows and main button title. Tints buttons with specified colour. Sets optional button with entered title and URL to open.
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color, mainButtonTitle: String? = nil, optionalButtonTitle: String, optionalButtonURL: URL?) {
        self.init(title: title, rows: rows, mainButtonTitle: mainButtonTitle)
        self.accentColor = accentColor
        self.isShowingOptionalButton = true
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonURL = optionalButtonURL
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        rows = try container.decode([WelcomeSheetPageRow].self, forKey: .rows)
        
        do {
            mainButtonTitle = try container.decode(String.self, forKey: .mainButtonTitle)
        } catch {
            mainButtonTitle = "Continue"
        }
        
        do {
            let colorHex = try container.decode(String.self, forKey: .accentColor)
            accentColor = Color(hex: colorHex)
        } catch {
            accentColor = nil
        }
        
        do {
            optionalButtonTitle = try container.decode(String.self, forKey: .optionalButtonTitle)
        } catch {
            optionalButtonTitle = nil
        }
        
        do {
            let urlString = try container.decode(String.self, forKey: .optionalButtonURL)
            optionalButtonURL = URL(string: urlString)
        } catch {
            optionalButtonURL = nil
        }
        
        do {
            isShowingOptionalButton = try container.decode(Bool.self, forKey: .isShowingOptionalButton)
        } catch {
            if optionalButtonTitle != nil {
                isShowingOptionalButton = true
            } else {
                isShowingOptionalButton = false
            }
        }
    }
}
