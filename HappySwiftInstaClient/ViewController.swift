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
    private let controllerData = DataHolder()
    @IBOutlet weak var viewWithImages: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWithImages.allowsSelection = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsersPics()
    }

    func loadUsersPics() {
        firstly {
            controllerData.firstAPICall()
            }.then { result in
                // Промисом маппится в реалм
                self.controllerData.writeJsonToRealm(jsonArray: result)
            }.always {
                 self.viewWithImages.reloadData()
            }.catch { e in
                print(e)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        var countOfCells = 0
        firstly {
            controllerData.getAllMedia()
            }.then { reslts -> Void in
                countOfCells = reslts.count
//                print(countOfCells)
            }.catch { e in
                print(e)
        }
        return countOfCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = ImageCollectionViewCell()
        guard let provectusCell = self.viewWithImages
            .dequeueReusableCell(withReuseIdentifier: "provectusCell",
                                 for: indexPath) as? ImageCollectionViewCell else {
                                    fatalError("Faile to fetch data")
        }
//        cell.itemsRow = allMedia[indexPath.row]
        cell = provectusCell
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipePhoto" {
            var indexPaths = self.viewWithImages.indexPathsForSelectedItems
            guard let destViewController = segue.destination as? ModalViewController else {
                return
            }
            var index_Path = indexPaths![0]
//            destViewController.recipeInfo = self.controllerData.mediaList[index_Path.row]
            self.viewWithImages.deselectItem(at: index_Path, animated: false)
        }
}
}



