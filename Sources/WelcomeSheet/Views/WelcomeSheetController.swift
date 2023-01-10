//
//  WelcomeSheetController.swift
//
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import UIKit

public class WelcomeSheetController: ModalUIHostingController {
    public init(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages, onDismiss: onDismiss))

        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
