//
//  WelcomeSheetController.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import UIKit

public class WelcomeSheetController {
    var pages: [WelcomeSheetPage]
    var isSlideToDismissDisabled: Bool
    var onDismiss: () -> Void
    
    init(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        self.pages = pages
        self.isSlideToDismissDisabled = isSlideToDismissDisabled
        self.onDismiss = onDismiss
    }

    func get() -> UIViewController {
        let hc = ModalUIHostingController(rootView: WelcomeSheetView(pages: pages, onDismiss: onDismiss))
        hc.isModalInPresentation = isSlideToDismissDisabled
        return hc
    }
    
    public static func get(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) -> UIViewController {
        WelcomeSheetController(pages: pages, isSlideToDismissDisabled: isSlideToDismissDisabled, onDismiss: onDismiss).get()
    }
}
