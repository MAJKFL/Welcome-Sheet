//
//  WelcomeSheetPageRow.swift
//
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// Describes Welcome Sheet page row's content.
public struct WelcomeSheetPageRow: Identifiable, Decodable {
    private enum CodingKeys : String, CodingKey {
        case title, content, imageName, accentColor
    }
    
    public var id = UUID()
    
    
    /// Title displayed above the content.
    public var title: String
    /// Text displayed beneath the title.
    public var content: String
    /// Image displayed at the beginning of a row.
    public var image: Image
    
    
    /// Color used for image. When `nil`, uses default accent color.
    public var accentColor: Color?
    
    
    // V SwiftUI Initializers V
    
    /// Creates Welcome Sheet page row with given image, title and content.
    public init(image: Image, accentColor: Color? = nil, title: String, content: String) {
        self.image = image
        self.accentColor = accentColor
        self.title = title
        self.content = content
    }

    /// Creates Welcome Sheet page row with system image, given title and content. Tints image with specified colour.
    public init(imageSystemName: String, accentColor: Color?, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), accentColor: accentColor, title: title, content: content)
    }

    /// Creates Welcome Sheet page row with image name, given title and content. Tints image with specified colour.
    public init(imageNamed: String, accentColor: Color?, title: String, content: String) {
        self.init(image: Image(imageNamed), accentColor: accentColor, title: title, content: content)
    }
    
    // V UIKit initializers V
    
    /// Creates Welcome Sheet page row with given image, title and content. Tints image with specified colour.
    public init(uiImage: UIImage, accentUIColor: UIColor? = nil, title: String, content: String) {
        if let systemSymbolName = uiImage.systemSymbolName() {
            self.init(imageSystemName: systemSymbolName, accentUIColor: accentUIColor, title: title, content: content)
        } else {
            self.init(image: Image(uiImage: uiImage), accentColor: accentUIColor?.toColor(), title: title, content: content)
        }
    }
    
    /// Creates Welcome Sheet page row with system image, given title and content. Tints image with specified colour.
    public init(imageSystemName: String, accentUIColor: UIColor?, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), accentColor: accentUIColor?.toColor(), title: title, content: content)
    }

    /// Creates Welcome Sheet page row with image name, given title and content. Tints image with specified colour.
    public init(imageNamed: String, accentUIColor: UIColor?, title: String, content: String) {
        self.init(image: Image(imageNamed), accentColor: accentUIColor?.toColor(), title: title, content: content)
    }
    
    // V Universal initializers V
    
    /// Creates Welcome Sheet page row with system image, given title and content. Tints image with specified colour.
    public init(imageSystemName: String, title: String, content: String) {
        self.init(image: Image(systemName: imageSystemName), title: title, content: content)
    }

    /// Creates Welcome Sheet page row with image name, given title and content. Tints image with specified colour.
    public init(imageNamed: String, title: String, content: String) {
        self.init(image: Image(imageNamed), title: title, content: content)
    }
    
    // V Codable initializer V
    
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
