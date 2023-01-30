//
//  WelcomeSheetController.swift
//
//
//  Created by Eskil Gjerde Sviggum on 29/01/2023.
//

import UIKit
import SwiftUI

@objc
public protocol WelcomeSheetDelegate: AnyObject {
    @objc
    optional func welcomeSheetController(didDismiss welcomeSheetController: UIViewController)
    
    @objc
    optional func welcomeSheetController(pages welcomeSheetController: UIViewController) -> [UIWelcomeSheetPage]
}

open class WelcomeSheetStoryboardController: ModalWelcomeSheetUIHostingController {
    
    @IBOutlet weak public var delegate: WelcomeSheetDelegate?
    
    /// Pages of the sheet.
    @IBOutlet
    public var pages: [UIWelcomeSheetPage] = [] {
        didSet {
            rootView.pages = pages.map { $0.welcomeSheetPage() }
        }
    }
    
    /// Closure called on dismissal of the sheet.
    public var onDismiss: (() -> Void)?
    
    /// Creates Welcome Sheet controller without pages and onDismiss action.
    public init() {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
        rootView.onDismiss = getOnDismiss(with: didDismiss)
    }
    
    /// Creates Welcome Sheet controller with given pages and onDismiss action.
    public init(pages: [UIWelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages.map { $0.welcomeSheetPage() }, onDismiss: {}))
        self.onDismiss = onDismiss
        rootView.onDismiss = getOnDismiss(with: didDismiss)
        
        self.pages = pages
        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required public init?(coder: NSCoder) {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
        rootView.onDismiss = getOnDismiss(with: didDismiss)
    }
    
    public override func viewDidLoad() {
        if let pages = delegate?.welcomeSheetController?(pages: self) {
            self.pages = pages
        } else {
            rootView.pages = pages.map { $0.welcomeSheetPage() }
        }
    }
    
    open func didDismiss() {
        delegate?.welcomeSheetController?(didDismiss: self)
        self.onDismiss?()
    }
}
