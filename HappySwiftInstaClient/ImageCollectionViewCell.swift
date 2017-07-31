//
//  ImageCollectionViewCell.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var captionLabel: UILabel?
    @IBOutlet var provectusImageView: UIImageView?
    var itemsRow: MediaViewModel! {
        didSet {
            self.setupItems()
        }
    }
    func setupItems() {
        let url = itemsRow.provectusImageView
        self.captionLabel?.text = "Tap for details."
        self.provectusImageView?.kf.setImage(with: url! as URL)
    }
}
