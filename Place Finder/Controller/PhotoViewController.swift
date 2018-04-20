//
//  PhotoViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import GooglePlaces
import SwiftyJSON

class PhotoViewController: UIViewController {
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loadJSON(detailJSON : JSON) {
//        print(detailJSON["result"]["international_phone_number"].stringValue)
//        loadFirstPhotoForPlace(placeID: <#T##String#>)
//    }
    
    func loadPlaceid(placeid : String) {
        loadFirstPhotoForPlace(placeID: placeid)
    }
    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    if let photos = photos?.results {
                        self.loadImageForMetadata(photoMetadata: firstPhoto)
                    }
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
//                self.imageView.image = photo;
//                self.attributionTextView.attributedText = photoMetadata.attributions;
                let firstImage = UIImageView()
                firstImage.image = photo
                self.photosCollectionView.addSubview(firstImage)
                firstImage.translatesAutoresizingMaskIntoConstraints = false
                firstImage.topAnchor.constraint(equalTo: self.photosCollectionView.topAnchor).isActive = true
                firstImage.leftAnchor.constraint(equalTo: self.photosCollectionView.leftAnchor).isActive = true
                firstImage.rightAnchor.constraint(equalTo: self.photosCollectionView.rightAnchor).isActive = true
                firstImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
            }
        })
    }
    
}
