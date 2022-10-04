//
//  WelcomeSheetController.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import SwiftUI

public class WelcomeSheetController {
    private var _showSheet: Bool = false
    private lazy var showSheet: Binding<Bool> = .init {
        self._showSheet
    } set: { newValue in
        self._showSheet = newValue
        self.onDismiss()
    }
    private var welcomeView: some View {
        WelcomeSheetView(pages: pages)
            .environment(\.showingSheet, showSheet)
    }

    private var pages: [WelcomeSheetPage]
    private var onDismiss: () -> Void

    init(pages: [WelcomeSheetPage], onDismiss: @escaping () -> Void) {
        self.pages = pages
        self.onDismiss = onDismiss
    }

    func get() -> UIViewController {
        return ModalUIHostingController(onDismiss: onDismiss, isSlideToDismissDisabled: true, rootView: welcomeView)
    }

    public static func get(pages: [WelcomeSheetPage], onDismiss: @escaping () -> Void) -> UIViewController {
        WelcomeSheetController(pages: pages, onDismiss: onDismiss).get()
    }
}
