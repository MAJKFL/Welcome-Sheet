//
//  ViewController.swift
//  UIKit-Storyboard-WelcomeSheetDemo
//
//  Created by Eskil Gjerde Sviggum on 18/01/2023.
//

import UIKit
import WelcomeSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let welcomeSheetController = segue.destination as? WelcomeSheetController {
            welcomeSheetController.delegate = self
        }
    }
    
    
}

extension ViewController: WelcomeSheetDelegate {
    
    func welcomeSheetController(didDismiss welcomeSheetController: UIViewController) {
        print("Did dismiss")
    }
    
}
