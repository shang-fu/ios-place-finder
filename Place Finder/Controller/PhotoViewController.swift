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
    
    var photosMetadata : [GMSPlacePhotoMetadata]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotoForPlace(placeID : self.placeid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlaceid(placeid : String) {
        self.placeid = placeid
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 300)
//
//        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myCollectionView!.dataSource = self
//        myCollectionView!.delegate = self
//        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//        myCollectionView!.backgroundColor = UIColor.white
//        self.view.addSubview(myCollectionView!)

//        loadListOfImages()
//        print("placeid = \(self.placeid)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photosMetadata = self.photosMetadata {
            return photosMetadata.count
        } else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)

        if let photosMetadata = self.photosMetadata {
            loadImageForMetadata(photoMetadata : photosMetadata[indexPath.row]) { (photo) in
                
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
                imageView.image = photo
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                myCell.addSubview(imageView)
            }
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
                    
                    
                    
//                    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//                    layout.itemSize = CGSize(width: self.view.frame.size.width, height: 400)
//
//                    self.myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//                    self.myCollectionView!.dataSource = self
//                    self.myCollectionView!.delegate = self
//                    self.myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//                    self.myCollectionView!.backgroundColor = UIColor.white
//                    self.view.addSubview(self.myCollectionView!)
                    
                    
                    
                    self.photosMetadata = photosMetadata
                    self.myCollectionView!.reloadData()
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
//                self.imageView.image = photo;
//                self.attributionTextView.attributedText = photoMetadata.attributions;
                completion(photo!)
            }
        })
    }
    
    
}
