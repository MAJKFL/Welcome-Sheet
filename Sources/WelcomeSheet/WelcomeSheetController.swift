//
//  WelcomeSheetController.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import UIKit

open class WelcomeSheetController: ModalWelcomeSheetUIHostingController {
    /// Pages of the sheet.
    public var pages: [WelcomeSheetPage] = [] {
        didSet {
            rootView.pages = pages
        }
    }
    
    /// Closure called on dismissal of the sheet.
    public var onDismiss: (() -> Void)?
    
    /// Creates Welcome Sheet controller without pages and onDismiss action.
    public init() {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
        rootView.onDismiss = getOnDismiss(with: didDismiss)
    }
    
    /// Creates Welcome Sheet controller with given pages and onDismiss action.
    public init(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages, onDismiss: {}))
        self.onDismiss = onDismiss
        rootView.onDismiss = getOnDismiss(with: didDismiss)
        
        self.pages = pages
        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required public init?(coder: NSCoder) {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
        rootView.onDismiss = getOnDismiss(with: didDismiss)
    }
    
    open func didDismiss() {
        self.onDismiss?()
    }
}
