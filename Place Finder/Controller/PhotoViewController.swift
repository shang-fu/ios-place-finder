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

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var photos : [JSON]?
    var placeid : String = ""
    var myCollectionView:UICollectionView?
    var photosData = [UIImage]()
    
    var photosMetadata : [GMSPlacePhotoMetadata]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotoForPlace(placeID : self.placeid)
    }
    
    func loadPlaceid(placeid : String) {
        self.placeid = placeid
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 250)

        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView!.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)

        if self.photosData.count != 0 {
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
            imageView.image = self.photosData[indexPath.row]
//            imageView.contentMode = UIViewContentMode.scaleAspectFit
            myCell.addSubview(imageView)
        }
        return myCell
    }
    
    
    
    
    func loadPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let photosMetadata = photos?.results {
 
                    self.photosMetadata = photosMetadata
                    
                    for index in 0...self.photosMetadata!.count - 1 {
                        self.loadImageForMetadata(photoMetadata : photosMetadata[index]) { (photo) in
                            self.photosData.append(photo)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.myCollectionView!.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata, completion: @escaping (UIImage) -> Void) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                completion(photo!)
            }
        })
    }
    
    
}
