//
//  ImageCollectionViewCell.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import Kingfisher
import AlamofireImage
import Alamofire

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var captionLabel: UILabel?
    @IBOutlet var provectusImageView: UIImageView?
    var medias = [Media]()
    var itemsRow: Media! {
        didSet {
            self.setupItems()
        }
    }
    func setupItems() {
        let url = itemsRow.provectusImageView
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value,
                let expectedlabel = self.captionLabel,
                let expectedImg = self.provectusImageView {
                expectedlabel.text = "Tap for details."
                expectedImg.image  = image
            }
        }

    }
}
