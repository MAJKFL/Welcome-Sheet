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
    func welcomeSheetController(didDismiss welcomeSheetController: UIViewController)
    
    func welcomeSheetController(pages welcomeSheetController: UIViewController) -> [WelcomeSheetPage]
}

@objc
public class WelcomeSheetControllerConfigurator: NSObject, WelcomeSheetDelegate {
    
    func welcomeSheetController(didDismiss welcomeSheetController: UIViewController) {
        didDismiss()
    }
    
    func welcomeSheetController(pages welcomeSheetController: UIViewController) -> [WelcomeSheetPage] {
        [
            WelcomeSheetPage(title: title, rows: rows.map { $0.rows() })
        ]
    }
    
    
    @IBInspectable
    var title: String = ""
    
    @IBOutlet
    var rows: [WelcomeSheetControllerConfiguratorPageRow] = []
    
    @IBAction
    func didDismiss() {
        
    }
    
    
}

@objc
public class WelcomeSheetControllerConfiguratorPageRow: NSObject {
    
    @IBInspectable
    public var title: String = ""
    
    @IBInspectable
    public var content: String = ""
    
    @IBInspectable
    public var image: UIImage = UIImage()
    
    func rows() -> WelcomeSheetPageRow {
        WelcomeSheetPageRow(image: Image(uiImage: image), title: title, content: content)
    }
    
}

public class WelcomeSheetController: ModalWelcomeSheetUIHostingController {
    
    @IBOutlet weak var delegate: WelcomeSheetDelegate?
    
    /// Pages of the sheet.
    public var pages = [WelcomeSheetPage]() {
        didSet {
            rootView.pages = pages
        }
    }
    
    /// Action performed after dismissing the sheet.
    override public var onDismiss: () -> Void {
        didSet {
            rootView.onDismiss = getOnDismiss(with: onDismiss)
        }
    }
    
    /// Creates Welcome Sheet controller without pages and onDismiss action.
    public init() {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
    }
    
    /// Creates Welcome Sheet controller with given pages and onDismiss action.
    public init(pages: [WelcomeSheetPage], isSlideToDismissDisabled: Bool = false, onDismiss: @escaping () -> Void = {}) {
        super.init(rootView: WelcomeSheetView(pages: pages, onDismiss: onDismiss))

        self.pages = pages
        self.isModalInPresentation = isSlideToDismissDisabled
    }
    
    required init?(coder: NSCoder) {
        super.init(rootView: WelcomeSheetView(pages: [], onDismiss: {}))
    }
    
    public override func viewDidLoad() {
        if let delegate {
            self.onDismiss = { delegate.welcomeSheetController(didDismiss: self) }
            self.pages = delegate.welcomeSheetController(pages: self)
        }
    }
}
