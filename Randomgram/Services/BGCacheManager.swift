//
//  BGCacheManager.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 24.02.2021.
//

import Foundation
import UIKit

class BGCacheManager {
    
    static var bgCache = [String : UIColor]()
    
    static func getBG(imageUrl: String) -> UIColor? {
        
        return bgCache[imageUrl]
        
    }
    
    static func saveBG(imageUrl: String, averageColor: UIColor) {
        
        bgCache[imageUrl] = averageColor
        
    }
}
