import SwiftUI

public struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    var pages: [WelcomeSheetPage]

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                WelcomeSheetView(pages: pages).environment(\.showingSheet, $showSheet)
            }
    }
}

public extension View {
    func welcomeSheet(isPresented showSheet: Binding<Bool>, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages))
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
