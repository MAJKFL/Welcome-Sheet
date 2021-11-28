// Source: https://stackoverflow.com/a/64839306

import SwiftUI

class ModalUIHostingController<Content>: UIHostingController<Content>, UIPopoverPresentationControllerDelegate where Content : View {
    
    var onDismiss: (() -> Void)
    
    required init?(coder: NSCoder) { fatalError("") }
    
    var width: CGFloat {
        let width = UIScreen.main.bounds.width
        
        if width >= 1024 { // iPad pro 12.9"
            return width / 1.65
        } else if width == 744 { // iPad mini (6th gen)
            return width / 1.2
        } else if width > 810 { // iPads bigger than standard iPad
            return width / 1.35
        } else { // The rest
            return width / 1.3
        }
    }
    
    var height: CGFloat {
        let height = UIScreen.main.bounds.height
        
        if height >= 1366 { // iPad pro 12.9"
            return height / 1.65
        } else if height == 1133 { // iPad mini (6th gen)
            return height / 1.7
        } else if height > 1080 { // iPads bigger than standard iPad
            return height / 1.6
        } else { // The rest
            return height / 1.5
        }
    }
    
    init(onDismiss: @escaping () -> Void, rootView: Content) {
        self.onDismiss = onDismiss
        super.init(rootView: rootView)
        preferredContentSize = CGSize(width: width, height: height)
        modalPresentationStyle = .formSheet
        presentationController?.delegate = self
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        print("modal dismiss")
        onDismiss()
    }
}

class ModalUIViewController<Content: View>: UIViewController {
    var isPresented: Bool
    var content: () -> Content
    var onDismiss: (() -> Void)
    private var hostVC: ModalUIHostingController<Content>
    
    private var isViewDidAppear = false
    
    required init?(coder: NSCoder) { fatalError("") }
    
    init(isPresented: Bool = false, onDismiss: @escaping () -> Void, content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, rootView: content())
        super.init(nibName: nil, bundle: nil)
    }
    
    func show() {
        guard isViewDidAppear else { return }
        self.hostVC = ModalUIHostingController(onDismiss: onDismiss, rootView: content())
        present(hostVC, animated: true)
    }
    
    func hide() {
        guard !hostVC.isBeingDismissed else { return }
        dismiss(animated: true)
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
    
    let content: () -> Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FormSheet<Content>>) -> ModalUIViewController<Content> {
    
        let onDismiss = {
            self.show = false
        }
        
        let vc = ModalUIViewController(isPresented: show, onDismiss: onDismiss, content: content)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ModalUIViewController<Content>,
                                context: UIViewControllerRepresentableContext<FormSheet<Content>>) {
        if show {
            uiViewController.show()
        }
        else {
            uiViewController.hide()
        }
    }
}

extension View {
    public func formSheet<Content: View>(isPresented: Binding<Bool>,
                                         @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(FormSheet(show: isPresented,
                                  content: content))
    }
}
