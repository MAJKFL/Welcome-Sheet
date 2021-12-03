//
//  WelcomeSheetPageRow.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// A type that describes welcome sheet page row's content.
public struct WelcomeSheetPageRow: Identifiable {
    public var id = UUID()
    
    
    /// Title displayed over a content.
    public var title: String
    /// Text displayed beneath a title.
    public var content: String
    /// Image displayed at the beginning of a row.
    public var image: Image
    
    
    /// Color used for an image. When set to nil, uses default accent colour.
    public var accentColor: Color?
    
    
    /// Creates welcome sheet page row with given image, title and content.
    public init(image: Image, title: String, content: String) {
        self.image = image
        self.title = title
        self.content = content
    }
    
    /// Creates welcome sheet page row with system image, given title and content.
    public init(imageSystemName: String, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), title: title, content: content)
    }

    /// Creates welcome sheet page row with given image, title and content. Tints image with specified colour.
    public init(image: Image, accentColor: Color, title: String, content: String) {
        self.init(image: image, title: title, content: content)
        self.accentColor = accentColor
    }

    /// Creates welcome sheet page row with system image, given title and content. Tints image with specified colour.
    public init(imageSystemName: String, accentColor: Color, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), title: title, content: content)
        self.accentColor = accentColor
    }
}
