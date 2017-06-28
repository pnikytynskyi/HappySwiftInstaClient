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
    var recipeInfo: MediaViewModel?
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
        let timeOfCreationPhoto = recipeInfo?.dateOfCreation
        let date = NSDate(timeIntervalSince1970: TimeInterval(IntMax(timeOfCreationPhoto!)!))
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        self.SomeImg.kf.setImage(with: recipeInfo!.someImg! as URL )
        self.DateOfCreation.text = "\(year) \(month)/\(day) \(hour):\(minutes)"
        self.OwnerData.text = recipeInfo?.ownerData
        self.userPhoto.kf.setImage(with: recipeInfo!.userPhoto! as URL )
    }

    

}
