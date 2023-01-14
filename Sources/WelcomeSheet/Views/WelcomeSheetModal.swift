//
//  WelcomeSheetModal.swift
//
//
//  Created by Jakub Florek on 14/01/2023.
//

import SwiftUI

public class ModalWelcomeSheetUIHostingController: UIHostingController<WelcomeSheetView>, UIPopoverPresentationControllerDelegate {
    var onDismiss: () -> Void
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") } // FIXME: Implement to make it work with storyboards
    
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
