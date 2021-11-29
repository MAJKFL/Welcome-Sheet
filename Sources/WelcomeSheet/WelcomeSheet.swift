import SwiftUI
 
struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    var pages: [WelcomeSheetPage]
    var onDismiss: () -> Void

    public func body(content: Content) -> some View {
        content
            .formSheet(isPresented: $showSheet, content: {
                WelcomeSheetView(pages: pages).environment(\.showingSheet, $showSheet)
            }, onDismiss: onDismiss)
    }
}

public extension View {
    func welcomeSheet(isPresented showSheet: Binding<Bool>, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: {}))
    }
    
    func welcomeSheet(isPresented showSheet: Binding<Bool>, pages: [WelcomeSheetPage], onDismiss: @escaping () -> Void) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss))
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
