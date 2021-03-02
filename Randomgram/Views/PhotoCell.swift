//
//  PhotoCell.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 07.02.2021.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
//    var currentImage : UIImage?
    lazy var background: UIColor = .black
    
    var randomPhoto: RandomPhoto? {
        
        didSet {
           // TODO: remove logic from the cell
            guard let randomPhoto = randomPhoto else {return}
            guard let imageUrl = URL(string: randomPhoto.urls.regular) else {return}
            
            imageView.kf.setImage(with: imageUrl)
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
}
