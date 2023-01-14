//
//  File.swift
//  
//
//  Created by Jakub Florek on 14/01/2023.
//

import SwiftUI

extension HorizontalAlignment {
    enum MidIcons: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    static let midIcons = HorizontalAlignment(MidIcons.self)
}
