//
//  ViewControllerHelper.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 7/16/17.
//  Copyright © 2017 pavel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import RealmSwift
import PromiseKit
class ViewControllerDataHolder: NSObject {
    /// token to my Insta account
    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    var mediaList: [MediaList]? = []
    var items = List<MediaList>()
    var results: [AnyObject]? {
        guard let media = realm.objects(MediaList.self).first else {return nil}
        return media.jsonData
    }
    let realm = try! Realm()
    override init() {
        super.init()
    }
    var url: String {
        return "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
    }

    func list() -> Promise<[AnyObject]> {
        return Promise { fulfill, reject in
            Alamofire.request(url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let dictionary = json as? [String: AnyObject],
                            let dic = dictionary["data"] as? [AnyObject]  else {
                            reject("not a dictionary" as! Error)
                            return
                        }
                        fulfill(dic)
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }

    @discardableResult func parceJsonToRealm(json: [AnyObject]) -> Promise<Any> {
        let media = MediaList()
        return Promise { fulfill, reject in
            if !json.isEmpty {
                do {
                    media.jsonData = json
                    try realm.write {
                        realm.add(media)
                    }
                } catch let error as NSError {
                    reject(error)
                }
                let a = realm.objects(MediaList.self)
                fulfill(a)
            } else {
                reject("Fail" as! Error)
            }
        }
    }

    func parseCell(_ path: [String: AnyObject]) -> MediaList? {
        var itemsRow = path
        guard let allImgs = itemsRow["images"] as? [String: AnyObject],
            let thumbImg = allImgs["low_resolution"] as? [String: AnyObject],
            let urlThumbString = thumbImg["url"] as? String,
            let userData = itemsRow["user"] as? [String: AnyObject],
            let fullNmae = userData["full_name"] as? String,
            let usrImg = userData["profile_picture"] as? String,
            let bigImg = allImgs["standard_resolution"] as? [String: AnyObject],
            let urlBigString = bigImg["url"] as? String,
            let timeOfCreation = itemsRow["created_time"] as? String
            else {
                print("Fatality fail")
                return nil
        }
        let sample = Media(userPhoto: usrImg, someImg: urlBigString,
                           dateOfCreation: timeOfCreation, ownerData: fullNmae,
                           lowRImg: urlThumbString)
        return MediaViewModel(media: sample)
    }

}
