import SwiftUI

public struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    var pages: [WelcomeSheetPage]

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                WelcomeSheetView(pages: pages)
            }
    }
}

public extension View {
    func welcomeSheet(isPresented showSheet: Binding<Bool>, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages))
    }
}
