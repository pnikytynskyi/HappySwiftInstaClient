//
//  ImageCollectionViewCell.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var captionLabel: UILabel?
    @IBOutlet var provectusImageView: UIImageView?
    var medias = [Media]()
    var itemsRow: Media! {
        didSet {
            self.setupItems()
        }
    }
    @discardableResult func setupItems() {
        let realm = try! Realm()
        let mediasObjects = realm.objects(Media.self)
        for media in mediasObjects {
            self.medias.append(media)
        }
        let url = itemsRow.provectusImageView
        self.captionLabel?.text = "Tap for details."
        self.provectusImageView?.kf.setImage(with: url as? URL)
    }
}
