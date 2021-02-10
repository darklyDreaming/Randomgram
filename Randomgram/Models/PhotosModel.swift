//
//  PhotosModel.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 07.02.2021.
//

import Foundation
import UIKit
import Kingfisher

protocol PhotosModelDelegate {
    func photosFetched(randomPhotosArray: [RandomPhoto])
    func addMorePhotos(randomPhotosArray: [RandomPhoto])
}

class PhotosModel {
    
    var requestService = APIRequestService()
    
    var delegate: PhotosModelDelegate?
    private lazy var urlsArray = [URL]()
    private lazy var randomPhotosArray = [RandomPhoto]()
    
    func getPhotos(update: Bool = false) {
        
        requestService.requestPhotos { (data) in
            
            guard let data = data else {
                print("No data retrieved from the API")
                return
            }
            
            let decoder = JSONDecoder()
            
            let randomPhotos = try? decoder.decode([RandomPhoto].self, from: data)
            
            guard let randomPhotosFetched = randomPhotos else {
                print("Sorry, something went wrong during decoding")
                return
            }
            if update {
                self.randomPhotosArray.append(contentsOf: randomPhotosFetched)
                self.delegate?.addMorePhotos(randomPhotosArray: self.randomPhotosArray)
            } else {
                self.randomPhotosArray = randomPhotosFetched
                self.delegate?.photosFetched(randomPhotosArray: self.randomPhotosArray)
            }
        }
    }
}
