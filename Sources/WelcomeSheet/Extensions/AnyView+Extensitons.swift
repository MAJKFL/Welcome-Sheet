//
//  File.swift
//  
//
//  Created by Jakub Florek on 14/01/2023.
//

import SwiftUI

extension AnyView: Identifiable {
    public var id: UUID {
        UUID()
    }
}
