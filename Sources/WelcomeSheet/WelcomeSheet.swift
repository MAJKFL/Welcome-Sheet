import SwiftUI
 
struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    let pages: [WelcomeSheetPage]
    let onDismiss: () -> Void
    let isSlideToDmismissDisabled: Bool

    func body(content: Content) -> some View {
        content
            .formSheet(isPresented: $showSheet, onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled, content: {
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
    func welcomeSheet(isPresented showSheet: Binding<Bool>, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: {}, isSlideToDmismissDisabled: false))
    }
    
    func welcomeSheet(isPresented showSheet: Binding<Bool>, onDismiss: @escaping () -> Void, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss, isSlideToDmismissDisabled: false))
    }
    
    func welcomeSheet(isPresented showSheet: Binding<Bool>, isSlideToDmismissDisabled: Bool, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: {}, isSlideToDmismissDisabled: isSlideToDmismissDisabled))
    }
    
    func welcomeSheet(isPresented showSheet: Binding<Bool>, onDismiss: @escaping () -> Void, isSlideToDmismissDisabled: Bool, pages: [WelcomeSheetPage]) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet, pages: pages, onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled))
    }
}
