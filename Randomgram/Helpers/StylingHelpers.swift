//
//  StylingHelpers.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 06.02.2021.
//

import Foundation
import UIKit

struct StylingHelpers {
    
    static func setupStandardLabel(label: UILabel) {
        
        let attributedText = NSAttributedString(string: "This small app was created\n with the help of the Kingfisher library\n and Unsplash API", attributes: AttributedStringsStyles.standardLabelText)
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        
    }
    
    static func setupNiceBarButton(button: UIBarButtonItem) {
        
        button.setTitleTextAttributes(AttributedStringsStyles.standardButtonText, for: .normal)
    }
    
}
