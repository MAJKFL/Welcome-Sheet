//
//  WelcomeSheetPageRow.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// A type that describes a WelcomeSheetPageRow's content.
public struct WelcomeSheetPageRow: Identifiable {
    public var id = UUID()
    public var title: String
    public var content: String
    public var image: Image
    public var accentColor: Color?

    public init(image: Image, title: String, content: String) {
        self.image = image
        self.title = title
        self.content = content
    }

    public init(imageSystemName: String, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), title: title, content: content)
    }

    public init(image: Image, accentColor: Color, title: String, content: String) {
        self.init(image: image, title: title, content: content)
        self.accentColor = accentColor
    }

    public init(imageSystemName: String, accentColor: Color, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), title: title, content: content)
        self.accentColor = accentColor
    }
}
