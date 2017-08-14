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
import ObjectMapper
class ViewControllerDataHolder: NSObject {
    /// token to my Insta account

    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    var mediaList = [Media]()
    var items = List<Media>()
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

    func getMedia(smallUrl: String) -> Promise<Results<Media>> {
        return Promise { fulfill, regect in
            let realm = try Realm()
            let object = realm.objects(Media.self).filter("provectusImageView == \(smallUrl)")
            fulfill(object)
            }.recover { error -> Results<Media> in
                throw error.apiError
        }
    }

    @discardableResult func writeJsonToRealm(jsonArray: [AnyObject]) -> Promise<Any> {
        return Promise { fulfill, reject in
            guard let media = Mapper<Media>().mapArray(JSONObject: jsonArray) else {
                return reject(ApiError(errorDescription:"ERROR"))
            }
            for m in media {
                mediaList.append(m)
            }
            let realm = try Realm()
            if !jsonArray.isEmpty {
                do {
                    try realm.write {
                        realm.add(media)
                    }
                } catch let error as NSError {
                    reject(error)
                }
                let allMedia = realm.objects(Media.self)
                fulfill(allMedia)
            } else {
                reject("Fail" as! Error)
            }
        }
    }

}
