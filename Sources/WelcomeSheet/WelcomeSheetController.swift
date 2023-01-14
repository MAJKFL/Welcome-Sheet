//
//  WelcomeSheetController.swift
//
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import UIKit

public class WelcomeSheetController: ModalWelcomeSheetUIHostingController {
    /// Pages of the sheet.
    var pages = [WelcomeSheetPage]() {
        didSet {
            rootView.pages = pages
        }
    }
    
    /// Action performed after dismissing the sheet.
    override var onDismiss: () -> Void {
        didSet {
            rootView.onDismiss = onDismiss
        }
    }
    
    /// Creates Welcome Sheet controller without pages and onDismiss action.
    public init() {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
    }
    
    /// Creates Welcome Sheet controller with given pages and onDismiss action.
    public init(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages, onDismiss: onDismiss))

        self.pages = pages
        self.onDismiss = onDismiss
        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") } // FIXME: Implement to make it work with storyboards
}
