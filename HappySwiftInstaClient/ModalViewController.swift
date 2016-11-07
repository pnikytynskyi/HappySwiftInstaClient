//
//  ModalViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit


class ModalViewController: UIViewController {

    @IBOutlet var SomeImg: UIImageView!
    
    @IBOutlet var DateOfCreation: UILabel!
    @IBOutlet var OwnerData: UILabel!
    var tmpImg : UIImageView!
    var tmpName: String!
    var recipeInfo: [String:AnyObject]? {
        didSet {
            self.setupImage()
            self.loadUsersInfo()
        }
    }

    override func viewDidLoad() {
        self.OwnerData.text = tmpName
        self.SomeImg.image =  tmpImg.image
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupImage(){
        guard let allImgs = self.recipeInfo?["images"] as? [String: AnyObject],
            let thumbImg = allImgs["standard_resolution"] as? [String: AnyObject],
            let urlThumbString = thumbImg["url"] as? String
            else {
                print("Fatality fail")
                return
        }
        
        let url = NSURL(string: urlThumbString)
        print("And the url is: \(url)")
//        accessing outlets before they're loaded in
        self.tmpImg.hnk_setImageFromURL(url as! URL )

    }
    func loadUsersInfo()  {
        guard let userdata = self.recipeInfo?["user"] as? [String: AnyObject],
            let fullNmae = userdata["full_name"] as? String
            else {
                print("Fatality fail")
                return
        }
        print("And the usernname is: \(fullNmae)")
//        accessing outlets before they're loaded in
        self.tmpName = fullNmae
    }

    

}
