//
//  ImageCollectionViewCell.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var provectusImageView: UIImageView!
    var ItemsRow: [String: AnyObject]! {
        didSet {
            self.setupItems()
        }
    }
    func setupItems(){
        guard let allImgs = self.ItemsRow["images"] as? [String: AnyObject],
            let thumbImg = allImgs["standard_resolution"] as? [String: AnyObject],
            let urlThumbString = thumbImg["url"] as? String
            else {
                print("Fatality fail")
                return
        }
        
        
        let url = NSURL(string: urlThumbString)
        self.captionLabel.text = "Tap for details."
        self.provectusImageView.hnk_setImageFromURL(url as! URL)
    }
    

}
