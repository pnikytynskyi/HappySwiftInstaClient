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
    var recipeImageName = String()
    var recipeInfo: [String:AnyObject]? {
        didSet {
            self.setupImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SomeImg.image = UIImage( contentsOfFile:self.recipeImageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print("And url is: \(url)")
        self.SomeImg.hnk_setImageFromURL(url as! URL )

    }
    

}
