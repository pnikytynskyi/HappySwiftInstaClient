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
class ViewController: UICollectionViewController {
    let controllerData = ViewControllerDataHolder()
    var willTransitionToPortrait = false
    var compactRegular = UITraitCollection()
    var anyAny = UITraitCollection()
    @IBOutlet weak var viewWithImages: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWithImages?.allowsSelection = true
        self.controllerData.setUpReferenceSizeClasses(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controllerData.loadUsersPics(controller: self)
        willTransitionToPortrait = self.view.frame.size.height >
            self.view.frame.size.width
    }

    func addMedia(media: MediaViewModel, index: Int) {
        if ((self.controllerData.media?.count)! >= index) {
            self.controllerData.media?.insert(media, at: index)
        } else {
            self.controllerData.media?.append(media)
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.controllerData.results?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "provectusCell",                                                for: indexPath) as! ImageCollectionViewCell
        if let thisItem = self.controllerData
            .results?[indexPath.row] as? [String : AnyObject] {
            self.addMedia(media: self.controllerData.parseCell(thisItem)!,
                          index: indexPath.row)
            cell.ItemsRow = self.controllerData.media?[indexPath.row]
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipePhoto") {
            var indexPaths = self.collectionView?.indexPathsForSelectedItems
            var destViewController : ModalViewController
            destViewController = segue.destination as! ModalViewController
            var index_Path = indexPaths![0]
            destViewController.recipeInfo = self.controllerData.media?[index_Path.row]
            self.viewWithImages?.deselectItem(at: index_Path, animated: false)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        willTransitionToPortrait = size.height > size.width
    }

    override func overrideTraitCollection(forChildViewController childViewController: UIViewController) -> UITraitCollection {
        let traitCollectionForOverride = (willTransitionToPortrait) ? compactRegular : anyAny
        print("77777777777777")
        return traitCollectionForOverride
    }
}


