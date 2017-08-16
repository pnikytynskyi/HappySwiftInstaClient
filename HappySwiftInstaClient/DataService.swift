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
public class DataService: NSObject {
    static let shared = DataService()
    var items = List<Media>()
    var localMedia = [Media]()
    override init() {
        super.init()
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

    func getAllMedia() -> Promise<Results<Media>> {
        return Promise { fulfill, regect in
            let realm = try Realm()
            let object = realm.objects(Media.self)
            fulfill(object)
            }.recover { error -> Results<Media> in
                throw error.apiError
        }
    }

    func getMediaAndSetVarLocalMedia() {
        guard let realm = try? Realm() else {
            fatalError("Can't init Realm")
        }
        let objects = realm.objects(Media.self).toArray()
        if !objects.isEmpty {
            localMedia = objects
        }
    }

    @discardableResult func writeJsonToRealm(jsonArray: [AnyObject]) -> Promise<Any> {
        return Promise { fulfill, reject in
            guard let media = Mapper<Media>().mapArray(JSONObject: jsonArray) else {
                return reject(ApiError(errorDescription:"ERROR"))
            }
            let realm = try Realm()
            if !jsonArray.isEmpty {
                do {
                    try realm.write {
                        realm.add(media, update: true)
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
