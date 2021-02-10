//
//  ImagesCollectionViewController.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 06.02.2021.
//

import UIKit
import Kingfisher

final class ImagesCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = Constants.CollectionView.photoCell
    
    var photosModel = PhotosModel()
    var randomPhotos = [RandomPhoto]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        photosModel.delegate = self
        photosModel.getPhotos()

    }
    

    // MARK: -UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return randomPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        if indexPath.row == randomPhotos.count - 5 {
            photosModel.getPhotos(update: true)
        }
        cell.randomPhoto = randomPhotos[indexPath.row]
        return cell
    }
}

// MARK: -Delegate Flow Layout Methods

extension UICollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height * 0.8
        let width = collectionView.frame.width * 0.9
        let size = CGSize(width: width, height: height)

        return size

    }
}

// MARK: - Photo Model Delegate Methods

extension ImagesCollectionViewController: PhotosModelDelegate {
    
    func photosFetched(randomPhotosArray: [RandomPhoto]) {
        self.randomPhotos = randomPhotosArray
        print("Success! Photos fetched correctly")
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func addMorePhotos(randomPhotosArray: [RandomPhoto]) {
        self.randomPhotos = randomPhotosArray
        print("Success! New photos coming")
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
