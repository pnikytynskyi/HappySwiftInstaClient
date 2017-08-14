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
        let timeOfCreationPhoto = recipeInfo?.dateOfCreation
//        let date = NSDate(timeIntervalSince1970: TimeInterval(IntMax(timeOfCreationPhoto!)!))
//        let calendar = Calendar.current
//        let year = calendar.component(.year, from: date as Date)
//        let month = calendar.component(.month, from: date as Date)
//        let day = calendar.component(.day, from: date as Date)
//        let hour = calendar.component(.hour, from: date as Date)
//        let minutes = calendar.component(.minute, from: date as Date)
//        self.someImg.kf.setImage(with: recipeInfo!.someImg! as URL )
//        self.dateOfCreation.text = "\(year) \(month)/\(day) \(hour):\(minutes)"
//        self.ownerData.text = recipeInfo?.ownerData
//        self.userPhoto.kf.setImage(with: recipeInfo!.userPhoto! as URL )
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
