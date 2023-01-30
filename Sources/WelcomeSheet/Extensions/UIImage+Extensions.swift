//
//  UIImage+Extensions.swift
//  
//
//  Created by Eskil Gjerde Sviggum on 30/01/2023.
//

import UIKit

extension UIImage {
    
    func systemSymbolName() -> String? {
        guard let imageAsset = self.imageAsset else {
            return nil
        }
        
        let systemSymbolAssetManagerName = "CoreGlyphs"
        
        // Get the assetName, and assetManagerName.
        guard
            imageAsset.responds(to: NSSelectorFromString("assetName")),
            let assetName = imageAsset.value(forKey: "_assetName") as? String,
            
            imageAsset.responds(to: NSSelectorFromString("_assetManager")),
            let assetManager = imageAsset.value(forKey: "_assetManager") as? NSObject,
            
            let assetManagerName = assetManager.value(forKey: "_assetManagerName") as? String
        else {
            assertionFailure("assetName or assetManagerName is not available.")
            return nil
        }
        
        // Check if image is a system symbol.
        if assetManagerName != systemSymbolAssetManagerName {
            return nil
        }
        
        return assetName
    }
    
}
