//
//  ModalViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import Foundation

class ModalViewController: UIViewController {
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet var SomeImg: UIImageView!
    @IBOutlet var DateOfCreation: UILabel!
    @IBOutlet var OwnerData: UILabel!
    var tmpImg : UIImageView!
    var tmpName: String!
    var recipeInfo: [String:AnyObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.loadUsersInfo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadUsersInfo()  {
        guard let userData = self.recipeInfo?["user"] as? [String: AnyObject],
        let fullNmae = userData["full_name"] as? String,
        let usrImg = userData["profile_picture"] as? String,
        let allImgs = self.recipeInfo?["images"] as? [String: AnyObject],
        let thumbImg = allImgs["standard_resolution"] as? [String: AnyObject],
        let urlThumbString = thumbImg["url"] as? String,
        let timeOfCreationPhoto = self.recipeInfo?["created_time"] as? String
            else {
                print("Fatality fail")
                return
        }
        let date = NSDate(timeIntervalSince1970: TimeInterval(IntMax(timeOfCreationPhoto)!))
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        self.SomeImg.hnk_setImageFromURL(NSURL(string: urlThumbString) as! URL )
        self.DateOfCreation.text = "\(year) \(month)/\(day) \(hour):\(minutes)"
        self.OwnerData.text = fullNmae
        self.userPhoto.hnk_setImageFromURL(NSURL(string: usrImg) as! URL )
    }

    

}
