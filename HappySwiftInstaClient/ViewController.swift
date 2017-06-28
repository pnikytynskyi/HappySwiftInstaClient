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
    /// token to my Insta account
    let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
    var media: [MediaViewModel]? = []
    var results: [AnyObject]? = []
    @IBOutlet var viewWithImages: UICollectionView!
    
    override func viewDidLoad() {
        self.viewWithImages.allowsSelection = true
        self.loadUsersPics()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func addMedia(media: MediaViewModel, index: Int) {
        if ((self.media?.count)! >= index) {
            self.media?.insert(media, at: index)
        } else {
            self.media?.append(media)
        }
    }

    func loadUsersPics() {
       let url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
        Alamofire.request(url, method: .get).responseJSON{ response in
            if let json = response.result.value {
                let JSON = json as! NSDictionary
                if let data = JSON["data"] as? [AnyObject] {
                    self.results = data
                    self.viewWithImages.reloadData()
                }
            } else {
                self.loadUsersPics()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "provectusCell",
                                                      for: indexPath) as! ImageCollectionViewCell
        let thisItem = self.results?[indexPath.row] as? [String : AnyObject]
        self.addMedia(media: whatCell(thisItem!)!, index: indexPath.row)
        cell.ItemsRow = media?[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipePhoto") {
            var indexPaths = self.collectionView?.indexPathsForSelectedItems
            var destViewController : ModalViewController
            destViewController = segue.destination as! ModalViewController
            var index_Path = indexPaths![0]
            destViewController.recipeInfo = self.media?[index_Path.row]
            self.viewWithImages.deselectItem(at: index_Path, animated: false)
            
        }
    }

    func whatCell(_ path: [String : AnyObject]) -> MediaViewModel? {
        var ItemsRow = path
        guard let allImgs = ItemsRow["images"] as? [String: AnyObject],
            let thumbImg = allImgs["low_resolution"] as? [String: AnyObject],
            let urlThumbString = thumbImg["url"] as? String,
            let userData = ItemsRow["user"] as? [String: AnyObject],
            let fullNmae = userData["full_name"] as? String,
            let usrImg = userData["profile_picture"] as? String,
            let bigImg = allImgs["standard_resolution"] as? [String: AnyObject],
            let urlBigString = bigImg["url"] as? String,
            let timeOfCreation = ItemsRow["created_time"] as? String
            else {
                print("Fatality fail")
                return nil
        }
        let sample = Media(userPhoto: usrImg, SomeImg: urlBigString,
                           DateOfCreation: timeOfCreation, OwnerData: fullNmae,
                           lowRImg: urlThumbString)
        return MediaViewModel(media: sample)
    }
}


