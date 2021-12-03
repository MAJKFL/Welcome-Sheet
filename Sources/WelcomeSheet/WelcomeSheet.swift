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

    func body(content: Content) -> some View {
        content
            .formSheet(isPresented: $showSheet, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, content: {
                WelcomeSheetView(pages: pages).environment(\.showingSheet, $showSheet)
            })
    }
}

struct ShowingSheetKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var showingSheet: Binding<Bool>? {
        get { self[ShowingSheetKey.self] }
        set { self[ShowingSheetKey.self] = newValue }
    }
}

public extension View {
    /// Presents welcome sheet with given pages when a binding to a Boolean value that you provide is true.
    func welcomeSheet(isPresented showSheet: Binding<Bool>, onDismiss: @escaping () -> Void = {}, isSlideToDismissDisabled: Bool = false, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled))
    }
}
