//
//  WelcomeSheetModal.swift
//
//
//  Created by Jakub Florek on 14/01/2023.
//

import SwiftUI

open class ModalWelcomeSheetUIHostingController: UIHostingController<WelcomeSheetView>, UIPopoverPresentationControllerDelegate {
    override internal init(rootView: WelcomeSheetView) {
        super.init(rootView: rootView)
        
        self.rootView.onDismiss = getOnDismiss(with: rootView.onDismiss)
        
        modalPresentationStyle = .formSheet
        preferredContentSize = CGSize(width: iPadSheetDimensions.width, height: iPadSheetDimensions.height)
        presentationController?.delegate = self
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) { rootView.onDismiss() }
    
    internal func getOnDismiss(with action: @escaping () -> Void) -> (() -> Void) {
        return { [weak self] in
            action()
            self?.dismiss(animated: true)
        }
    }
}

class ModalWelcomeSheetUIViewController: UIViewController {
    var isSlideToDismissDisabled: Bool?
    var welcomeSheetView: WelcomeSheetView?
    
    func show() {
        guard let welcomeSheetView else { return }
        let hostVC = ModalWelcomeSheetUIHostingController(rootView: welcomeSheetView)
        hostVC.overrideUserInterfaceStyle = self.overrideUserInterfaceStyle
        hostVC.isModalInPresentation = isSlideToDismissDisabled ?? false
        present(hostVC, animated: true)
    }
}

struct ModalWelcomeSheetUIViewControllerRepresentable: UIViewControllerRepresentable {
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
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ModalWelcomeSheetUIViewControllerRepresentable>) -> ModalWelcomeSheetUIViewController {
        let vc = ModalWelcomeSheetUIViewController()
        vc.welcomeSheetView = welcomeSheetView
        vc.isSlideToDismissDisabled = isSlideToDismissDisabled
        
        if let userInterfaceStyle {
            vc.overrideUserInterfaceStyle = userInterfaceStyle
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ModalWelcomeSheetUIViewController, context: UIViewControllerRepresentableContext<ModalWelcomeSheetUIViewControllerRepresentable>) {
        if show {
            uiViewController.show()
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
}
