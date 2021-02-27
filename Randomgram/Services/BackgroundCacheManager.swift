//
//  BGCacheManager.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 24.02.2021.
//

import Foundation
import UIKit

class BackgroundCacheManager {
    
    static var bgCache = [String : UIColor]()

    static func getBG(id: String) -> UIColor? {
        return bgCache[id]
    }
    
    static func saveBG(id: String, averageColor: UIColor) {
        bgCache[id] = averageColor
    }
    
    static func clearCache() {
        bgCache = [String : UIColor]()
    }
}
