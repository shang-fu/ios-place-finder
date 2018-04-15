//
//  ViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/14/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 1
                self.favoriteView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 0
                self.favoriteView.alpha = 1
            })
        }
    }
}

