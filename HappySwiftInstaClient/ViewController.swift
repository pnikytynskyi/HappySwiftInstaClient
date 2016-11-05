//
//  ViewController.swift
//  HappySwiftInstaClient
//
//  Created by pavel on 11/3/16.
//  Copyright © 2016 pavel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.borderColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func borderColor() {
        usernameTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
    }
    @IBAction func signInTapped(_ sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        FIRAuth.auth()?.signIn(withEmail: username!, password: password!, completion: { (user, error ) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Incorrect Username/Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // error while logging in
            } else {
                let alert = UIAlertController(title: "Success", message: "You are logged in.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // success
            }
        })
    }


}

