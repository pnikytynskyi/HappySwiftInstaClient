//
//  ViewControllerDataHolder.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 7/16/17.
//  Copyright © 2017 pavel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import Foundation
class ViewControllerDataHolder: NSObject {
    /// token to my Insta account
    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    var media: [MediaViewModel]? = []
    var results: [AnyObject]? = []
    override init() {
        super.init()
    }

    func loadUsersPics(controller: ViewController) {
        let url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(self.accessToken)"
        Alamofire.request(url, method: .get).responseJSON{ response in
            if let json = response.result.value {
                let JSON = json as! NSDictionary
                if let data = JSON["data"] as? [AnyObject] {
                    self.results = data
                    controller.viewWithImages?.reloadData()
                }
            } else {
                self.loadUsersPics(controller: controller)
            }
        }
    }
    
    func parseCell(_ path: [String : AnyObject]) -> MediaViewModel? {
        var ItemsRow = path
        guard let allImgs = ItemsRow["images"] as? [String: AnyObject],
            let thumbImg = allImgs["low_resolution"] as? [String: AnyObject],
            let urlThumbString = thumbImg["url"] as? String,
            let userData = ItemsRow["user"] as? [String: AnyObject],
            let fullNmae = userData["full_name"] as? String,
            let usrImg = userData["profile_picture"] as? String,
            let bigImg = allImgs["standard_resolution"] as? [String: AnyObject],
            let urlBigString = bigImg["url"] as? String,
            let timeOfCreation = ItemsRow["created_time"] as? String
            else {
                print("Fatality fail")
                return nil
        }
        let sample = Media(userPhoto: usrImg, SomeImg: urlBigString,
                           DateOfCreation: timeOfCreation, OwnerData: fullNmae,
                           lowRImg: urlThumbString)
        return MediaViewModel(media: sample)
    }

    func setUpReferenceSizeClasses(controller: ViewController) {

        let traitCollectionHCompact = UITraitCollection(
            horizontalSizeClass: UIUserInterfaceSizeClass.compact)
        let traitCollectionVRegular = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.regular)
        controller.compactRegular = UITraitCollection(traitsFrom:
            [traitCollectionHCompact, traitCollectionVRegular])

        let traitCollectionHAny = UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.unspecified)
        let traitCollectionVAny = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.unspecified)
        controller.anyAny = UITraitCollection(traitsFrom:
            [traitCollectionHAny, traitCollectionVAny])
    }
    
}
