// Source: https://stackoverflow.com/a/68481116

import SwiftUI

class ModalUIHostingController<Content>: UIHostingController<Content>, UIPopoverPresentationControllerDelegate where Content : View {
    var isDismissedBySliding: Bool
    let onDismiss: (() -> Void)
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(onDismiss: @escaping () -> Void, isSlideToDmismissDisabled: Bool, rootView: Content) {
        self.onDismiss = onDismiss
        self.isDismissedBySliding = false
        super.init(rootView: rootView)
        preferredContentSize = CGSize(width: iPadSheetDimensions.width, height: iPadSheetDimensions.height)
        modalPresentationStyle = .formSheet
        presentationController?.delegate = self
        isModalInPresentation = isSlideToDmismissDisabled
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        isDismissedBySliding = true
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss()
    }
}

class ModalUIViewController<Content: View>: UIViewController {
    let isPresented: Bool
    let isSlideToDmismissDisabled: Bool
    let content: () -> Content
    let onDismiss: () -> Void
    var hostVC: ModalUIHostingController<Content>
    
    private var isViewDidAppear = false
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(isPresented: Bool = false, onDismiss: @escaping () -> Void, isSlideToDmismissDisabled: Bool, content: @escaping () -> Content) {
        self.isSlideToDmismissDisabled = isSlideToDmismissDisabled
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled, rootView: content())
        super.init(nibName: nil, bundle: nil)
    }
    
    func show() {
        guard isViewDidAppear else { return }
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled, rootView: content())
        present(hostVC, animated: true)
    }
    
    func hide() {
        guard !hostVC.isBeingDismissed else { return }

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
    let isSlideToDmismissDisabled: Bool
    let content: () -> Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FormSheet<Content>>) -> ModalUIViewController<Content> {
        let onDismiss = {
            self.onDismiss()
            self.show = false
        }
        
        let vc = ModalUIViewController(isPresented: show, onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled, content: content)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ModalUIViewController<Content>, context: UIViewControllerRepresentableContext<FormSheet<Content>>) {
        if show {
            uiViewController.show()
        } else if !uiViewController.hostVC.isDismissedBySliding {
            uiViewController.hide()
        }
    }
}

extension View {
    func formSheet<Content: View>(isPresented: Binding<Bool>, onDismiss: @escaping () -> Void, isSlideToDmismissDisabled: Bool, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(FormSheet(show: isPresented, onDismiss: onDismiss, isSlideToDmismissDisabled: isSlideToDmismissDisabled, content: content))
    }
}
