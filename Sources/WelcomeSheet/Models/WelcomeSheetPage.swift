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
        case backgroundColor
        case preferredColorScheme
        case isShowingOptionalButton
        case optionalButtonTitle
        case optionalButtonURL
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
    /// Sheet's background color.
    public var backgroundColor: Color?
    /// Sheet's color scheme.
    public var preferrecColorScheme: ColorScheme?
    
    
    /// Specifies whether to show optional button.
    public var isShowingOptionalButton = false
    /// Optional button title.
    public var optionalButtonTitle: String?
    /// URL to open when optional button is tapped.
    public var optionalButtonURL: URL?
    /// Clousure executed when optional button is tapped.
    public var optionalButtonAction: (() -> ())?
    /// View shown after optional button is tapped.
    public var optionalButtonView: AnyView?
    
    
    /// Creates welcome sheet page.
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color? = nil, backgroundColor: Color? = nil, preferredColorScheme: ColorScheme? = nil, mainButtonTitle: String? = nil, optionalButtonTitle: String? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil) {
        self.title = title
        self.rows = rows
        self.mainButtonTitle = mainButtonTitle ?? "Continue"
        self.accentColor = accentColor
        self.backgroundColor = backgroundColor
        self.preferrecColorScheme = preferredColorScheme
        self.isShowingOptionalButton = true
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonURL = optionalButtonURL
        self.optionalButtonAction = optionalButtonAction
    }
    
    /// Creates welcome sheet page with custom optional button view.
    public init(title: String, rows: [WelcomeSheetPageRow], accentColor: Color? = nil, backgroundColor: Color? = nil, preferredColorScheme: ColorScheme?, mainButtonTitle: String? = nil, optionalButtonTitle: String? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonView: (() -> some View)? = nil) {
        self.init(title: title, rows: rows, accentColor: accentColor, backgroundColor: backgroundColor, preferredColorScheme: preferredColorScheme, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction)
        
        if let optionalButtonView {
            self.optionalButtonView = AnyView(optionalButtonView())
        }
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
            let colorHex = try container.decode(String.self, forKey: .backgroundColor)
            backgroundColor = Color(hex: colorHex)
        } catch {
            accentColor = nil
        }
        
        do {
            let raw = try container.decode(String.self, forKey: .preferredColorScheme)
            preferrecColorScheme = raw == "dark" ? .dark : (raw == "light" ? .light : nil)
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
