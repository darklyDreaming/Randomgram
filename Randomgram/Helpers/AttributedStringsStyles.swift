//
//  AttributedStringsStyles.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 06.02.2021.
//

import Foundation
import UIKit

struct AttributedStringsStyles {
    
    static let standardButtonText: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.black,
        .font : UIFont(name: "Arial Hebrew", size: 20),
    ]
    
    static let standardLabelText: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.black,
        .font : UIFont(name: "Arial Hebrew", size: 24)
    ]
    
    static let standardTitleText: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.black,
        .font : UIFont(name: "Arial Hebrew", size: 28),
    ]
    
    
}
