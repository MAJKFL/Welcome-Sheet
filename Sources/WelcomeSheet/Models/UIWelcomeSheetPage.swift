//
//  UIWelcomeSheetPage.swift
//  
//
//  Created by Eskil Gjerde Sviggum on 18/01/2023.
//

import UIKit

@objc
public class UIWelcomeSheetPage: NSObject {
    
    /// Large title displayed on the top.
    @IBInspectable
    public var title: String = ""
    
    /// Rows of content inside body.
    @IBOutlet
    public var rows: [UIWelcomeSheetPageRow] = []
    
    /// Title for the main button. Set to `"Continue"` by
    @IBInspectable
    public var mainButtonTitle: String = "Continue"
    
    /// Color used for main buttons. When `nil`, uses default accent color.
    @IBInspectable
    public var accentColor: UIColor?
    
    /// Background color. When `nil`, uses default system background.
    @IBInspectable
    public var backgroundColor: UIColor?
    
    /// Specifies whether to show the optional button.
    @IBInspectable
    public var isShowingOptionalButton = false
    
    /// Optional button title.
    @IBInspectable
    public var optionalButtonTitle: String?
    
    /// URL to open after optional button is tapped.
    @IBInspectable
    public var optionalButtonURL: String?
    
    /// Clousure executed after optional button is tapped.
    public var optionalButtonAction: (() -> ())?
    
    /// Clousure executed after optional button is tapped.
    public var optionalButtonView: UIView?
    
    func welcomeSheetPage() -> WelcomeSheetPage {
        WelcomeSheetPage(title: title, rows: rows.map { $0.welcomeSheetPageRow() }, accentUIColor: accentColor, backgroundUIColor: backgroundColor, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: URL(string: optionalButtonURL ?? ""), optionalButtonAction: optionalButtonAction, optionalButtonUIView: optionalButtonView)
    }
}
