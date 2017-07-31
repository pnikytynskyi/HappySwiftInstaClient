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
    init(userPhoto: String, someImg: String, dateOfCreation: String, ownerData: String,
         lowRImg: String) {
        self.photo = userPhoto
        self.bigImg = someImg
        self.dOfCreation = dateOfCreation
        self.ownerD = ownerData
        self.lowResImg = lowRImg
    }
}

/// Model of user's info, images
class MediaViewModel {
    private var media: Media
    var ownerData: String? {
        return media.ownerD
    }
    var dateOfCreation: String? {
        return media.dOfCreation
    }
    var userPhoto: NSURL? {
        return NSURL(string: media.photo)
    }
    var someImg: NSURL? {
        return NSURL(string: media.bigImg)
    }
    var provectusImageView: NSURL? {
        return NSURL(string: media.lowResImg)
    }
    init(media: Media) {
        self.media = media
    }
}
