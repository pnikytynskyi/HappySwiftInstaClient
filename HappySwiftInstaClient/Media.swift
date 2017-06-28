//
//  File.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/13/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import Foundation

/// this struct is meant to hold user's info
struct Media {
    var photo = ""
    var bigImg = ""
    var dOfCreation = ""
    var lowResImg = ""
    var ownerD = ""
    init(userPhoto: String, SomeImg: String, DateOfCreation: String, OwnerData: String,
         lowRImg: String) {
        self.photo = userPhoto
        self.bigImg = SomeImg
        self.dOfCreation = DateOfCreation
        self.ownerD = OwnerData
        self.lowResImg = lowRImg
    }
}


/// Model of user's info, images
class MediaViewModel {
    private var media: Media?
    var ownerData: String? {
        return media?.ownerD
    }
    var dateOfCreation: String? {
        return media?.dOfCreation
    }
    var userPhoto: NSURL? {
        guard let userPhoto = media?.photo
            else {
                return nil
        }
        return NSURL(string: userPhoto)
    }
    var someImg: NSURL? {
        guard let someImg = media?.bigImg
            else {
                return nil
        }
        return NSURL(string: someImg)
    }
    var provectusImageView: NSURL? {
        guard let provectusImageView = media?.lowResImg
            else {
                return nil
        }
        return NSURL(string: provectusImageView)
    }
    init(media: Media) {
        self.media = media
    }
}
