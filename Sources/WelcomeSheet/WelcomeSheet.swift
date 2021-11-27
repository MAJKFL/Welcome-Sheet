import SwiftUI

struct WelcomeSheet: ViewModifier {
    @Binding var showSheet: Bool
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                Text("Hello World!")
            }
    }
}

extension View {
    func welcomeSheet(isPresented showSheet: Binding<Bool>) -> some View {
        modifier(WelcomeSheet(showSheet: showSheet))
    }
}
