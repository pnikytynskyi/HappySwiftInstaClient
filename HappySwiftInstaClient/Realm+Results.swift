//
//  Realm+Results.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 8/15/17.
//  Copyright © 2017 pavel. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [T] {
        var array = [T]()
        for result in self {
            array.append(result)
        }
        return array
    }
}
