//
//  iPadSheetDimensions.swift
//  
//
//  Created by Jakub Florek on 29/11/2021.
//

import SwiftUI

struct iPadSheetDimensions {
    static var width: CGFloat {
        let width = UIScreen.main.bounds.width
        
        if width >= 1024 { // iPad pro 12.9"
            return width / 1.65
        } else if width == 744 || width == 768 { // iPad mini (6th gen), older iPads
            return width / 1.2
        } else if width > 810 { // iPads bigger than standard iPad
            return width / 1.35
        } else { // The rest
            return width / 1.3
        }
    }
    
    static var height: CGFloat {
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
}
