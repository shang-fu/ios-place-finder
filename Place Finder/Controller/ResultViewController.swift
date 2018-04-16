//
//  ResultViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var indexes : [String : String]?
    var latLong : [String : String]?
    
    let searchPlaces = SearchPlaces()

    @IBOutlet weak var labeltest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.indexes!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
