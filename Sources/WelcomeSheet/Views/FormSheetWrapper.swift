// Source: https://stackoverflow.com/a/68481116

import SwiftUI

class ModalUIHostingController<Content>: UIHostingController<Content>, UIPopoverPresentationControllerDelegate where Content : View {
    var isDismissedBySliding: Bool
    let onDismiss: (() -> Void)
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(onDismiss: @escaping () -> Void, isSlideToDismissDisabled: Bool, rootView: Content) {
        self.onDismiss = onDismiss
        self.isDismissedBySliding = false
        super.init(rootView: rootView)
        preferredContentSize = CGSize(width: iPadSheetDimensions.width, height: iPadSheetDimensions.height)
        modalPresentationStyle = .formSheet
        presentationController?.delegate = self
        isModalInPresentation = isSlideToDismissDisabled
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isDismissedBySliding = true
        onDismiss()
    }
}

class ModalUIViewController<Content: View>: UIViewController {
    var shouldUpdate: Bool
    
    let isPresented: Bool
    let isSlideToDismissDisabled: Bool
    let content: () -> Content
    let onDismiss: () -> Void
    var hostVC: ModalUIHostingController<Content>
    
    private var isViewDidAppear = false
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(isPresented: Bool = false, onDismiss: @escaping () -> Void, isSlideToDismissDisabled: Bool, content: @escaping () -> Content) {
        self.isSlideToDismissDisabled = isSlideToDismissDisabled
        self.shouldUpdate = isPresented
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, rootView: content())
        super.init(nibName: nil, bundle: nil)
    }
    
    func show() {
        guard isViewDidAppear else { return }
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, rootView: content())
        shouldUpdate = true
        present(hostVC, animated: true)
    }
    
    func hide() {
        guard !hostVC.isBeingDismissed else { return }
        
        shouldUpdate = false

        dismiss(animated: true) {
            self.hostVC.presentationControllerDidDismiss(self.presentationController!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isViewDidAppear = true
        if isPresented {
            show()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isViewDidAppear = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        show()
    }
}

struct FormSheet<Content: View> : UIViewControllerRepresentable {
    @Binding var show: Bool
    
    let onDismiss: () -> Void
    let isSlideToDismissDisabled: Bool
    let content: () -> Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FormSheet<Content>>) -> ModalUIViewController<Content> {
        let onDismiss = {
            self.onDismiss()
            self.show = false
        }
        
        let vc = ModalUIViewController(isPresented: show, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, content: content)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ModalUIViewController<Content>, context: UIViewControllerRepresentableContext<FormSheet<Content>>) {
        if show {
            uiViewController.show()
        } else if !uiViewController.hostVC.isDismissedBySliding && uiViewController.shouldUpdate {
            uiViewController.hide()
        }
    }
}

extension View {
    func formSheet<Content: View>(isPresented: Binding<Bool>, onDismiss: @escaping () -> Void, isSlideToDismissDisabled: Bool, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(FormSheet(show: isPresented, onDismiss: onDismiss, isSlideToDismissDisabled: isSlideToDismissDisabled, content: content))
    }
}
