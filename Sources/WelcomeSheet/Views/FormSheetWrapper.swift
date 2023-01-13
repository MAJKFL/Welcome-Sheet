// Source: https://stackoverflow.com/a/68481116

import SwiftUI

public class ModalUIHostingController: UIHostingController<WelcomeSheetView>, UIPopoverPresentationControllerDelegate {
    var onDismiss: () -> Void
    
    required init?(coder: NSCoder) { fatalError("") }
    
    override init(rootView: WelcomeSheetView) {
        self.onDismiss = rootView.onDismiss
        super.init(rootView: rootView)
        
        self.rootView.onDismiss = { [weak self] in
            rootView.onDismiss()
            self?.dismiss(animated: true)
        }
        
        modalPresentationStyle = .formSheet
        preferredContentSize = CGSize(width: iPadSheetDimensions.width, height: iPadSheetDimensions.height)
        presentationController?.delegate = self
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) { onDismiss() }
}

class ModalUIViewController: UIViewController {
    var isSlideToDismissDisabled: Bool?
    var welcomeSheetView: WelcomeSheetView?
    
    func show() {
        guard let welcomeSheetView else { return }
        let hostVC = ModalUIHostingController(rootView: welcomeSheetView)
        hostVC.overrideUserInterfaceStyle = self.overrideUserInterfaceStyle
        hostVC.isModalInPresentation = isSlideToDismissDisabled ?? false
        present(hostVC, animated: true)
    }
}

struct FormSheet: UIViewControllerRepresentable {
    let show: Bool
    let isSlideToDismissDisabled: Bool
    let preferredColorScheme: ColorScheme?
    let welcomeSheetView: WelcomeSheetView
    
    var userInterfaceStyle: UIUserInterfaceStyle? {        
        if preferredColorScheme == .dark {
            return .dark
        } else {
            return .light
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FormSheet>) -> ModalUIViewController {
        let vc = ModalUIViewController()
        vc.welcomeSheetView = welcomeSheetView
        vc.isSlideToDismissDisabled = isSlideToDismissDisabled
        
        if let userInterfaceStyle {
            vc.overrideUserInterfaceStyle = userInterfaceStyle
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ModalUIViewController, context: UIViewControllerRepresentableContext<FormSheet>) {
        if show {
            uiViewController.show()
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
}

extension View {
    func formSheet(isPresented: Bool, isSlideToDismissDisabled: Bool, preferredColorScheme: ColorScheme?, welcomeSheetView: WelcomeSheetView) -> some View {
        self.background(FormSheet(show: isPresented, isSlideToDismissDisabled: isSlideToDismissDisabled, preferredColorScheme: preferredColorScheme, welcomeSheetView: welcomeSheetView))
    }
}
