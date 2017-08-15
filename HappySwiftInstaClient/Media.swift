//
//  File.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/13/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
/// Model of user's info, images
class Media: Object, StaticMappable {
    dynamic var userPhoto = ""
    dynamic var someImg = ""
    dynamic var id = ""
    dynamic var dateOfCreation = Date()
    dynamic var provectusImageView = ""
    dynamic var ownerData = ""

    class func objectForMapping(map: Map) -> BaseMappable? {
        return Media()
    }
    override class func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        userPhoto           <- map["user.profile_picture"]
        someImg             <- map["images.standard_resolution.url"]
        id                  <- map["images.standard_resolution.url"]
        ownerData           <- map["user.full_name"]
        dateOfCreation      <- (map["created_time"], DateTransform())
        provectusImageView  <- map["images.low_resolution.url"]
    }
}


















