//
//  ModalViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/6/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import Foundation
import PromiseKit
import Alamofire
import AlamofireImage

class ModalViewController: UIViewController {
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var someImg: UIImageView!
    @IBOutlet weak var dateOfCreation: UILabel!
    @IBOutlet weak var ownerData: UILabel!
    var userPhotoFrameSize: CGSize?
    var recipeInfo: Media?

// MARK: constraints

    @IBOutlet weak var topConstraintForBigPicture: NSLayoutConstraint?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsersInfo()
        self.updateContentViewLayout(with: UIScreen.main.bounds.size)
    }
    func loadUsersInfo() {
        guard let desiredInfo = recipeInfo else {
            fatalError("Can not get recipeInfo")
        }
        let date = desiredInfo.dateOfCreation
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        Alamofire.request(desiredInfo.someImg).responseImage { response in
            if let image = response.result.value {
                 self.someImg.image = image
            }
        }
        Alamofire.request(desiredInfo.userPhoto).responseImage { response in
            if let image = response.result.value {
                 self.userPhoto.image = image
            }
        }

        self.dateOfCreation.text = "\(year) \(month)/\(day)"
        self.ownerData.text = desiredInfo.ownerData
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateContentViewLayout(with: size)
    }
    private func updateContentViewLayout(with size: CGSize) {
        if UIDevice.current.orientation.isLandscape {
            self.userPhoto.isHidden = true
            self.dateOfCreation.isHidden = true
            self.ownerData.isHidden = true
            let userPhotoFrameHeight = self.userPhotoFrameSize != nil ?
                self.userPhotoFrameSize!.height : CGFloat(150)
            self.topConstraintForBigPicture?.constant = -(userPhotoFrameHeight + 22)
        } else if UIDevice.current.orientation.isPortrait {
            self.userPhoto.isHidden = false
            self.dateOfCreation.isHidden = false
            self.ownerData.isHidden = false
            userPhotoFrameSize = userPhoto.frame.size
            self.topConstraintForBigPicture?.constant = 40
        }
    }

}
