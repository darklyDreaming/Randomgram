//
//  BGCacheManager.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 24.02.2021.
//

import Foundation
import UIKit

class BackgroundCacheManager {
    
    static var backgroundCache = [String : UIColor]()

    static func getBackground(id: String) -> UIColor? {
        return backgroundCache[id]
    }
    
    static func saveBackground(id: String, averageColor: UIColor) {
        backgroundCache[id] = averageColor
    }
    
    static func clearCache() {
        backgroundCache = [String : UIColor]()
    }
}
