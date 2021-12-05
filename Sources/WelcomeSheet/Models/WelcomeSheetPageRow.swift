//
//  WelcomeSheetPageRow.swift
//  
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// A type that describes welcome sheet page row's content.
public struct WelcomeSheetPageRow: Identifiable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case title
        case content
        case imageName
        case accentColor
    }
    
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        
        let imageName = try container.decode(String.self, forKey: .imageName)
        
        if let uiImage = UIImage(named: imageName) {
            image = Image(uiImage: uiImage)
        } else {
            image = Image(systemName: imageName)
        }
        
        do {
            let colorHex = try container.decode(String.self, forKey: .accentColor)
            accentColor = Color(hex: colorHex)
        } catch {
            accentColor = nil
        }
    }
}
