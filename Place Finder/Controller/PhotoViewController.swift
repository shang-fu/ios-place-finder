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
    
//    var images = [AnyObject]()
    var photos : [JSON]?
    var placeid : String = ""
    var myCollectionView:UICollectionView?
    
    var photosMetadata : [GMSPlacePhotoMetadata]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 60)
//
//        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myCollectionView!.dataSource = self
//        myCollectionView!.delegate = self
//        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//        myCollectionView!.backgroundColor = UIColor.white
//        self.view.addSubview(myCollectionView!)
        
        loadPhotoForPlace(placeID : self.placeid)
//        self.myCollectionView!.reloadData()
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlaceid(placeid : String) {
//        print(detailJSON["result"]["international_phone_number"].stringValue)
//        loadFirstPhotoForPlace(placeID: <#T##String#>)
//        self.photos = detailJSON["result"]["photos"].arrayValue
        self.placeid = placeid
        
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)

        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView!.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView!)

//        loadListOfImages()
        print("placeid = \(self.placeid)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.images.count
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
//        myCell.backgroundColor = UIColor.black
        
//        let imageDictionary = self.images[indexPath.row] as! NSDictionary
//        let imageUrlString = imageDictionary.object(forKey: "thumb") as! String
//        let imageUrl:NSURL = NSURL(string: imageUrlString)!
//
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
//            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
//
//            DispatchQueue.main.async {
//
//                let image = UIImage(data: imageData as Data)
//                imageView.image = image
//                imageView.contentMode = UIViewContentMode.scaleAspectFit
//
//                myCell.addSubview(imageView)
//            }
//        }
        
        if let photosMetadata = self.photosMetadata {
            loadImageForMetadata(photoMetadata : photosMetadata[indexPath.row]) { (photo) in
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:myCell.frame.size.height))
                //            let image = UIImage(data: imageData as Data)
                imageView.image = photo
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                
                myCell.addSubview(imageView)
            }
        }
        
//        loadImageForMetadata(photoMetadata : self.photosMetadata![indexPath.row]) { (photo) in
//            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
////            let image = UIImage(data: imageData as Data)
//            imageView.image = photo
//            imageView.contentMode = UIViewContentMode.scaleAspectFit
//
//            myCell.addSubview(imageView)
//        }
        
        
        return myCell
    }
    
    
    func loadPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let photosMetadata = photos?.results {
                    
//                    self.loadImageForMetadata(photoMetadata: firstPhoto)
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
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        print("User tapped on item \(indexPath.row)")
//
//        let imageDictionary = self.images[indexPath.row] as! NSDictionary
//        let imageUrlString = imageDictionary.object(forKey: "thumb") as! String
//
//        print("Image url = \(imageUrlString)")
//    }
    
    
//    func loadListOfImages()
//    {
//        // Send HTTP GET Request
//
//        // Define server side script URL
//        let scriptUrl = "http://swiftdeveloperblog.com/list-of-images/"
//
//        // Add one parameter just to avoid caching
//        let urlWithParams = scriptUrl + "?UUID=\(NSUUID().uuidString)"
//
//        // Create NSURL Ibject
//        let myUrl = URL(string: urlWithParams);
//
//        // Creaste URL Request
//        var request = URLRequest(url:myUrl!)
//
//        // Set request HTTP method to GET. It could be POST as well
//        request.httpMethod = "GET"
//
//
//        // Excute HTTP Request
//        let task = URLSession.shared.dataTask(with: request) {
//            data, response, error in
//
//            // Check for error
//            if error != nil
//            {
//                print("error=\(error)")
//                return
//            }
//
//            // Convert server json response to NSDictionary
//            do {
//                if let convertedJsonIntoArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
//
//                    self.images = convertedJsonIntoArray as [AnyObject]
//
//                    DispatchQueue.main.async {
//                        self.myCollectionView!.reloadData()
//                    }
//
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//
//        }
//
//        task.resume()
//    }
    
    
    

    
    
}
