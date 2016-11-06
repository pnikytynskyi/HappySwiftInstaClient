//
//  ModalViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit


class ModalViewController: UIViewController {

    @IBOutlet weak var SomeImg: UIImageView!
    
    @IBOutlet weak var DateOfCreation: UILabel!
    @IBOutlet weak var OwnerData: UILabel!
    var recipeImageName = String()
    var recipeInfo: [String:AnyObject]? {
        didSet {
            self.setupImage()
        }
    }

    override func viewDidLoad() {
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
        self.SomeImg.hnk_setImageFromURL(url as! URL )

    }
    

}
