import SwiftUI

public struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                Text("Hello World!")
            }
    }
}

public extension View {
    func welcomeSheet(isPresented showSheet: Binding<Bool>) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet))
    }
}
