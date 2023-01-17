//
//  ViewController.swift
//  UIKit-WelcomeSheetDemo
//
//  Created by Kevin Romero Peces-Barba on 6/10/22.
//

import UIKit
import WelcomeSheet

class ViewController: UIViewController {

    @IBOutlet weak var showSheetButton: UIButton!

    let pages = [
        WelcomeSheetPage(title: "Welcome to Welcome Sheet",
            rows: [
                WelcomeSheetPageRow(imageSystemName: "rectangle.stack.fill.badge.plus",
                                    accentColor: .mint,
                                    title: "Quick Creation",
                                    content: "It's incredibly intuitive. Simply declare an array of pages filled with content."),

                WelcomeSheetPageRow(imageNamed: "gears",
                                    accentColor: .indigo,
                                    title: "Highly Customisable",
                                    content: "Match sheet's appearance to your app, link buttons, perform actions after dismissal."),

                WelcomeSheetPageRow(imageSystemName: "ipad.and.iphone",
                                    accentColor: UIColor.green,
                                    title: "Works out of the box",
                                    content: "Don't worry about various screen sizes. It will look gorgeous on every iOS device.")
            ],
            accentColor: .purple,
            optionalButtonTitle: "About Welcome Sheet...",
            optionalButtonURL: URL(string: "https://github.com/MAJKFL/Welcome-Sheet")),

        WelcomeSheetPage(title: "What's New in Translate",
            rows: [
            ],
            mainButtonTitle: "Wassup?"),

        WelcomeSheetPage(title: "Welcome to Reminders",
            rows: [
                WelcomeSheetPageRow(imageSystemName: "note.text.badge.plus",
                                    accentColor: UIColor.green,
                                    title: "Quick Creation",
                                    content: "Simply type, ask Siri, or use the quick toolbar to create reminders."),

                WelcomeSheetPageRow(imageSystemName: "rectangle.grid.2x2.fill",
                                    accentColor: .init(red: 0.00, green: 0.70, blue: 1.00),
                                    title: "Easy Organizing", content: "Create lists to match your needs and categorize reminders with tags. Collaborate with others by sharing lists and assigning individual tasks."),

                WelcomeSheetPageRow(imageSystemName: "lightbulb.fill",
                                    accentColor: UIColor.orange,
                                    title: "Suggestions and Smart Lists",
                                    content: "Suggestions help you organize quickly, and smart lists automatically group reminders.")
            ],
            accentColor: .blue),

        WelcomeSheetPage(title: "What's New in Maps",
            rows: [
                WelcomeSheetPageRow(imageSystemName: "map.fill",
                                    accentColor: UIColor.green,
                                    title: "Updated Map Style",
                                    content: "An improved design makes it easier to navigate and explore the map."),

                WelcomeSheetPageRow(imageSystemName: "mappin.and.ellipse",
                                    accentColor: UIColor.red,
                                    title: "All-New Place Cards",
                                    content: "Completely redesigned place cards make it easier to learn about and interact with places."),

                WelcomeSheetPageRow(imageSystemName: "magnifyingglass",
                                    accentColor: UIColor.blue,
                                    title: "Improved Search",
                                    content: "Finding places is now easier with filters and automatic updates when you're browsing results on the map.")
            ],
            accentColor: .pink,
            mainButtonTitle: "Let's go!",
            optionalButtonTitle: "About Apple Maps & Privacy...",
            optionalButtonURL: URL(string: "https://apple.com"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        //showSheetButton.addTarget(self, action: #selector(showSheet), for: .touchUpInside)
    }

    @objc func showSheet() {
        let sheetVC = WelcomeSheetController(pages: self.pages, isSlideToDismissDisabled: true, onDismiss: sheetDismissed)

        present(sheetVC, animated: true)
    }

    func sheetDismissed() {
        print("Sheet dismissed")
    }
}

