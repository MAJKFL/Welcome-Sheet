//
//  WelcomeSheetController.swift
//
//
//  Created by Kevin Romero Peces-Barba on 2/10/22.
//

import UIKit
import SwiftUI

@objc
protocol WelcomeSheetDelegate: AnyObject {
    @objc
    optional func welcomeSheetController(didDismiss welcomeSheetController: UIViewController)
    
    @objc
    optional func welcomeSheetController(pages welcomeSheetController: UIViewController) -> [UIWelcomeSheetPage]
}

public class WelcomeSheetController: ModalWelcomeSheetUIHostingController {
    
    @IBOutlet weak var delegate: WelcomeSheetDelegate?
    
    /// Pages of the sheet.
    @IBOutlet
    public var pages: [UIWelcomeSheetPage] = [] {
        didSet {
            rootView.pages = pages.map { $0.welcomeSheetPage() }
        }
    }
    
    /// Creates Welcome Sheet controller without pages and onDismiss action.
    public init() {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
        rootView.onDismiss = didDismiss
    }
    
    /// Creates Welcome Sheet controller with given pages and onDismiss action.
    public init(pages: [UIWelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages.map { $0.welcomeSheetPage() }, onDismiss: {}))
        self.onDismiss = onDismiss
        rootView.onDismiss = didDismiss
        
        self.pages = pages
        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required init?(coder: NSCoder) {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
    }
    
    public override func viewDidLoad() {
        if let pages = delegate?.welcomeSheetController?(pages: self) {
            self.pages = pages
        } else {
            rootView.pages = pages.map { $0.welcomeSheetPage() }
        }
    }
    
    func didDismiss() {
        delegate?.welcomeSheetController?(didDismiss: self)
        self.onDismiss()
    }
}
