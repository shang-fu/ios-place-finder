//
//  FavoriteViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/14/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import EasyToast

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailDirectToFavorite {
    var defaults = UserDefaults.standard
    var favoritePlaces = [[String : String]]()
    var myTableView: UITableView!
    
    var primaryKey = ""
    var placeid = ""
    var name = ""
    var iconUrl = ""
    var vicinity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        self.updateFavorites()
        
        
    }
    
    func reloadDB() {
        for (key, value) in defaults.dictionaryRepresentation() {

            if let favoritePlace = value as? [String : String] {
                favoritePlaces.append(favoritePlace)
                print("HELLO3")
                print(favoritePlace["name"]!)
            }
            else {
                // obj is not a string array
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? CustomFavoriteCell) != nil {
            self.primaryKey = favoritePlaces[indexPath.row]["primaryKey"]!
            self.placeid = favoritePlaces[indexPath.row]["id"]!
            self.name = favoritePlaces[indexPath.row]["name"]!
            self.iconUrl = favoritePlaces[indexPath.row]["iconUrl"]!
            self.vicinity = favoritePlaces[indexPath.row]["vicinity"]!
            performSegue(withIdentifier: "favoriteToDetailVC", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFavoriteCell", for: indexPath) as! CustomFavoriteCell
        
        // adding author photo
        let url = URL(string: favoritePlaces[indexPath.row]["iconUrl"]!)
        if let url = url {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.icon.image = UIImage(data: data!)
        }
        
        // adding name
        cell.name.text = "\(favoritePlaces[indexPath.row]["name"]!)"
        
        // adding address
        cell.address.text = "\(favoritePlaces[indexPath.row]["vicinity"]!)"
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print(index.row)
            print("more button tapped")
            self.defaults.removeObject(forKey: self.favoritePlaces[index.row]["primaryKey"]!)
            self.view.showToast("\(self.favoritePlaces[index.row]["name"]!) was removed from favorites", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
            self.updateFavorites()
        }
        delete.backgroundColor = UIColor.red

        return [delete]
    }
    
    func favoritesSort() {
        favoritePlaces = favoritePlaces.sorted(by: { (favorite1: [String : String], favorite2: [String : String]) -> Bool in
            return favorite1["time"]! < favorite2["time"]!
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteToDetailVC" {
            let secondVC = segue.destination as! DetailViewController
            secondVC.placeid = self.placeid
            secondVC.primaryKey = self.primaryKey
            secondVC.name = self.name
            secondVC.iconUrl = self.iconUrl
            secondVC.vicinity = self.vicinity
            secondVC.delegateDirectToFavorite = self
        }
    }
    
    func updateFavorites() {
        // delete all views
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
        
        // reloading data
        self.favoritePlaces.removeAll()
        self.reloadDB()
        self.favoritesSort()
        
        if favoritePlaces.count == 0 {
            let reviewLabel = UILabel()
            view.addSubview(reviewLabel)
            reviewLabel.translatesAutoresizingMaskIntoConstraints = false
            reviewLabel.text = "No Favorites"
            reviewLabel.font = UIFont.boldSystemFont(ofSize: 13)
            reviewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            reviewLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            reviewLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            reviewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        } else {
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            
            myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 131))
            myTableView.register(UINib(nibName: "CustomFavoriteCell", bundle: nil), forCellReuseIdentifier: "customFavoriteCell")
            myTableView.dataSource = self
            myTableView.delegate = self
            self.view.addSubview(myTableView)
            
        }
        if let tableView = self.myTableView {
            tableView.reloadData()
        }
    }


}
