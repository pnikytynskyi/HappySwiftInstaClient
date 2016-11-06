//
//  ViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/3/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Haneke
import Alamofire

let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"
class ViewController: UIViewController,  UICollectionViewDataSource {


    var results: [AnyObject]? = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUsersPics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadUsersPics() {

       let url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
        Alamofire.request(url, method: .get).responseJSON{ response in
            if let json = response.result.value {
                let JSON = json as! NSDictionary
                if let data = JSON["data"] as! [AnyObject]? {
                    self.results = data
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "provectusCell", for: indexPath) as! ImageCollectionViewCell

        cell.ProvectusRow = self.results?[indexPath.row] as! [String : AnyObject]
        return cell
    }

    var largePhotoIndexPath: NSIndexPath? {
        didSet {
            //2
            var indexPaths = [IndexPath]()
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath as IndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue as IndexPath)
            }
            //3
            collectionView?.performBatchUpdates({
                self.collectionView?.reloadItems(at: indexPaths)
            }) { completed in
                //4
                if let largePhotoIndexPath = self.largePhotoIndexPath {
                    self.collectionView?.scrollToItem(
                        at: largePhotoIndexPath as IndexPath,
                        at: .centeredVertically,
                        animated: true)
                }
            }
        }
    }

}

