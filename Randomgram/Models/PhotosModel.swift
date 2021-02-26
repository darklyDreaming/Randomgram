//
//  PhotosModel.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 07.02.2021.
//

import Foundation
import UIKit
import Kingfisher

protocol PhotosModelDelegate: class {
    /// This function is called by the Photo Model when it successfully fetches a new array of photos.
    /// - Parameter randomPhotosArray: Contains a new array of photos fetched from the API.
    func photosFetched(randomPhotosArray: [RandomPhoto])
    /// This function is called by the Photo Model when the user had scrolled far enough to the end of the feed and triggered the getPhotos(update: true) function.
    /// - Parameter randomPhotosArray: Contains an updated array of photos fetched from the API.
    func addMorePhotos(newPhotosArray: [RandomPhoto])
}

class PhotosModel {
    
    weak var delegate: PhotosModelDelegate?
    private var requestService = APIRequestService()
    private lazy var randomPhotosArray = [RandomPhoto]()
    
    /// This function receives an array of random photos from the API Service.
    /// It is used to form a new array of random photos and reset the view in case the user taps Refresh button.
    /// To add more photos to the collection set the update parameter to true.
    /// - Parameter update: Set to true in order to add more photos to the feed.
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
                self.getAverageColors(photos: self.randomPhotosArray)
                self.delegate?.addMorePhotos(newPhotosArray: randomPhotosFetched)
            } else {
                self.randomPhotosArray = randomPhotosFetched
                self.getAverageColors(photos: self.randomPhotosArray)
                self.delegate?.photosFetched(randomPhotosArray: self.randomPhotosArray)
            }
        }
    }
    
    /// This func gets small images and processes them to create a cache of backgrounds to be displayed for each cell.
    /// - Parameter photos: an array of photos to be processed.
    func getAverageColors(photos: [RandomPhoto]) {
        
        let downloader = ImageDownloader.default

        DispatchQueue.global(qos: .userInteractive).async {
            
            for photo in photos {
                
                guard let smallImageUrl = URL(string: photo.urls.small) else {
                    continue
                }
                downloader.downloadImage(with: smallImageUrl) { result in
                    
                    switch result {
                    case .success(let value):
                        
                        let averageColor = value.image.averageColor
                        BGCacheManager.saveBG(id: photo.id, averageColor: averageColor ?? .lightGray)
                        
                    case .failure:
                        break
                    }
                    
                }
            }
            
        }
    }
    
}
