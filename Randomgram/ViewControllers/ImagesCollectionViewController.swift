//
//  ImagesCollectionViewController.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 06.02.2021.
//

import UIKit
import Kingfisher

final class ImagesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    private let reuseIdentifier = Constants.CollectionView.photoCell
    
    var photosModel = PhotosModel()
    var randomPhotos = [RandomPhoto]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.alpha = 0
        photosModel.delegate = self
        photosModel.getPhotos()

    }
    
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
            self.collectionView.alpha = 0
        } completion: { (completed) in
            DispatchQueue.main.async {
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
                self.collectionView.isPagingEnabled = true
            }
            self.photosModel.getPhotos()
        }
        
    }
    
    // MARK: -UICollectionViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let cell = collectionView.visibleCells.first as? PhotoCell
        guard let cellImage = cell?.currentImage else {return}
        
        if let averageColor = cellImage.averageColor {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.collectionView.backgroundColor = averageColor
            }, completion: nil)
        }
        
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
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: height)

        return size

    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Photo Model Delegate Methods

extension ImagesCollectionViewController: PhotosModelDelegate {
    
    func photosFetched(randomPhotosArray: [RandomPhoto]) {
        
        self.randomPhotos = randomPhotosArray
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            UIView.animate(withDuration: 1.2, delay: 0, options: .curveEaseOut, animations: {
                self.collectionView.alpha = 1
            }, completion: nil)
        }
    
    }

    func addMorePhotos(randomPhotosArray: [RandomPhoto]) {
        
        self.randomPhotos = randomPhotosArray
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}
