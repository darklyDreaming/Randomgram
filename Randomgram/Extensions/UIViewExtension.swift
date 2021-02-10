//
//  UIViewExtension.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 06.02.2021.
//

import Foundation
import UIKit

extension UIView {
    
    static func setupStandardLabel(label: UILabel) -> UILabel {
        
        let attributedText = NSAttributedString(string: "This small app was create with the help of the Kingfisher library and Unsplash API", attributes: AttributedStringsStyles.standardLabelText)
        label.attributedText = attributedText
        label.textAlignment = .justified
        
        return label
    }
    
}
