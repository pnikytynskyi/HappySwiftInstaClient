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
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let controllerData = ViewControllerDataHolder()
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
            controllerData.list()
            }.then { result in
                // Промисом парсишь в реалм
                self.controllerData.parceJsonToRealm(json: result)
            }.always {
                 self.viewWithImages.reloadData()
            }.catch { e in
    
        }
    }

    func addMedia(media: MediaViewModel, index: Int) {
        if (self.controllerData.media?.count)! >= index {
            self.controllerData.media?.insert(media, at: index)
        } else {
            self.controllerData.media?.append(media)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.controllerData.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = ImageCollectionViewCell()
        if let thisItem = self.controllerData
            .results?[indexPath.row] as? [String: AnyObject],
            let provectusCell = viewWithImages.dequeueReusableCell(
                withReuseIdentifier: "provectusCell", for: indexPath)
                as? ImageCollectionViewCell {
            cell = provectusCell
            self.addMedia(media: self.controllerData.parseCell(thisItem)!,
                          index: indexPath.row)
            cell.itemsRow = self.controllerData.media?[indexPath.row]
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipePhoto" {
            var indexPaths = self.viewWithImages.indexPathsForSelectedItems
            guard let destViewController = segue.destination as? ModalViewController else {
                return
            }
            var index_Path = indexPaths![0]
            destViewController.recipeInfo = self.controllerData.media?[index_Path.row]
            self.viewWithImages.deselectItem(at: index_Path, animated: false)
        }
    }

}
