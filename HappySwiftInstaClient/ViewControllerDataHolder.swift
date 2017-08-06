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
import UIKit
import PromiseKit
class ViewControllerDataHolder: NSObject {
    /// token to my Insta account
    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    var media: [MediaViewModel]? = []
    var results: [AnyObject]? = []
    override init() {
        super.init()
    }
    var url: String {
        return "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
    }

    func loadUsersPics(controller: ViewController) {
        Alamofire.request(url, method: .get).responseJSON { response in
            if let json = response.result.value,
                let JSON = json as? NSDictionary {
                if let data = JSON["data"] as? [AnyObject] {
                    self.results = data
                    controller.viewWithImages.reloadData()
                }
            } else {
                self.loadUsersPics(controller: controller)
            }
        }
    }

    func list() -> Promise<[String: Any]> {
        return Promise { fulfill, reject in
            Alamofire.request(url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let dictionary = json as? [String: Any] else {
                            reject("not a dictionary" as! Error)
                            return
                        }
                        fulfill(dictionary)
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }

    func parseCell(_ path: [String: AnyObject]) -> MediaViewModel? {
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
