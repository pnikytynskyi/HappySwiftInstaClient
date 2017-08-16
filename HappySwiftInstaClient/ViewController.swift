//
//  ViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/3/16.
//  Copyright © 2016 pavel. All rights reserved.
//

/// Please add all frameworks as embeded binaries in the General menu

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import Foundation
import PromiseKit
import RealmSwift
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var viewWithImages: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWithImages.allowsSelection = true
        DataService.shared.getMediaAndSetVarLocalMedia() // get local Realm data
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsersPics()
    }

    func loadUsersPics() {
        firstly {
            NetService.shared.firstAPICall()
            }.then { result in
                // Промисом маппится в реалм
                DataService.shared.writeJsonToRealm(jsonArray: result)
            }.always {
                 self.viewWithImages.reloadData()
            }.catch { e in
                print(e)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return DataService.shared.localMedia.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let provectusCell = self.viewWithImages
            .dequeueReusableCell(withReuseIdentifier: "provectusCell",
                                 for: indexPath) as? ImageCollectionViewCell else {
                                    fatalError("Faile to fetch data")
        }
        provectusCell.itemsRow = DataService.shared.localMedia[indexPath.row]
        return provectusCell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipePhoto" {
            var indexPaths = self.viewWithImages.indexPathsForSelectedItems
            guard let destViewController = segue.destination as? ModalViewController else {
                return
            }
            var index_Path = indexPaths![0]
            destViewController.recipeInfo = DataService.shared.localMedia[index_Path.row]
            self.viewWithImages.deselectItem(at: index_Path, animated: false)
        }
}
}



