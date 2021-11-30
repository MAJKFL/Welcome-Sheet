//
//  iPhoneDimensions.swift
//  
//
//  Created by Jakub Florek on 29/11/2021.
//

import SwiftUI

struct iPhoneDimensions {
    static let screenHeight = UIScreen.main.bounds.height
    
    static var spacing: CGFloat {
        if UIScreen.main.nativeBounds.height == 2340 || screenHeight < 736 { // iPhone mini, Smaller than iPhone plus
            return 30
        } else { // The rest
            return 60
        }
    }
    
    static var topPadding: CGFloat {
        if screenHeight == 568 { // iPhone SE 1st gen
            return 50
        } else if screenHeight <= 736 { // Smaller than iPhone plus
            return 60
        } else { // The rest
            return 80
        }
    }
    
    static var horizontalPaddingAddend: CGFloat {
        if screenHeight * UIScreen.main.nativeScale >= 896 * 3 || screenHeight == 736 { // iPhone pro max, iPhone plus
            return 20
        } else if screenHeight == 568 { // iPhone SE 1st gen
            return -10
        } else { // The rest
            return 0
        }
    }
}
