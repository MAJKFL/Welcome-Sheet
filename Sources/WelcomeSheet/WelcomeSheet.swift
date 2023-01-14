//
//  WelcomeSheet.swift
//
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI
 
struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    
    let pages: [WelcomeSheetPage]
    let onDismiss: () -> Void
    let isSlideToDismissDisabled: Bool
    let preferredColorScheme: ColorScheme?

    func body(content: Content) -> some View {
        content
            .background(ModalWelcomeSheetUIViewControllerRepresentable(show: showSheet, isSlideToDismissDisabled: isSlideToDismissDisabled, preferredColorScheme: preferredColorScheme, welcomeSheetView: WelcomeSheetView(pages: pages, onDismiss: getOnDismiss())))
    }
    
    func getOnDismiss() -> () -> Void {
        return {
            showSheet = false
            onDismiss()
        }
    }
}

public extension View {
    /// Presents Welcome Sheet with given pages when a binding to a Boolean value that you provide is true.
    func welcomeSheet(isPresented showSheet: Binding<Bool>, onDismiss: @escaping () -> Void = {}, isSlideToDismissDisabled: Bool = false, preferredColorScheme: ColorScheme? = nil, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, preferredColorScheme: preferredColorScheme))
    }
}
