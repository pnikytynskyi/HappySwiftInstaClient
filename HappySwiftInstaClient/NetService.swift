//
//  NetService.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 8/16/17.
//  Copyright © 2017 pavel. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import RealmSwift
import PromiseKit
import ObjectMapper
public class NetService: NSObject {
    static let shared = NetService()
    /// token to my Insta account

    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    override init() {
        super.init()
    }
    var url: String {
        return "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
    }

    func firstAPICall() -> Promise<[AnyObject]> {
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
}
