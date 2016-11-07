//
//  ViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/3/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Haneke
import Foundation
let accessToken = "4118608180.f19655b.284e7365f677467890393d6460f60423"

class ViewController: UICollectionViewController {
    var results: [AnyObject]? = []
    @IBOutlet var collection_View: UICollectionView!
    override func viewDidLoad() {
        self.collection_View.allowsSelection = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.loadUsersPics()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadUsersPics() {
       let url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
        Alamofire.request(url, method: .get).responseJSON{ response in
            if response.result.value != nil {
                if let json = response.result.value {
                    let JSON = json as! NSDictionary
                    if let data = JSON["data"] as? [AnyObject] {
                        self.results = data
                        self.collection_View.reloadData()
                    }
                }
            } else {
                self.loadUsersPics()
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "provectusCell", for: indexPath) as! ImageCollectionViewCell

        cell.ItemsRow = self.results?[indexPath.row] as? [String : AnyObject]
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipePhoto") {
            var indexPaths = self.collectionView?.indexPathsForSelectedItems
            var destViewController : ModalViewController
            destViewController = segue.destination as! ModalViewController
            var index_Path = indexPaths![0] as IndexPath
            destViewController.recipeInfo = self.results?[index_Path.row] as? [String : AnyObject]
            self.collection_View.deselectItem(at: index_Path, animated: false)
            
        }
    }
}


