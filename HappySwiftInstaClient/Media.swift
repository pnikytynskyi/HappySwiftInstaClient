//
//  File.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/13/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import Foundation
import RealmSwift
///// this struct is meant to hold user's info
//class Media : Object {
//    dynamic var photo = ""
//    dynamic var bigImg = ""
//    dynamic var dOfCreation = ""
//    dynamic var lowResImg = ""
//    dynamic var ownerD = ""
//
//}

/// Model of user's info, images
class MediaList: Object {
    dynamic var jsonData = [AnyObject]()
    dynamic var photo = ""
    dynamic var bigImg = ""
    dynamic var dOfCreation = ""
    dynamic var lowResImg = ""
    dynamic var ownerD = ""
    dynamic var ownerData: String? {
        return self.ownerD
    }
    dynamic var dateOfCreation: String? {
        return self.dOfCreation
    }
    dynamic var userPhoto: NSURL? {
        return NSURL(string: self.photo)
    }
    dynamic var someImg: NSURL? {
        return NSURL(string: self.bigImg)
    }
    dynamic var provectusImageView: NSURL? {
        return NSURL(string: self.lowResImg)
    }
}
