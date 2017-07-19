//
//  LandingPageController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

class LandingPageController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSForegroundColorAttributeName: Constants.placeholderWhiteColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSForegroundColorAttributeName: Constants.placeholderWhiteColor])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        let userEmail: String = emailTextField.text!
        let userPassword: String = passwordTextField.text!
        Auth.auth().signIn( withEmail: userEmail, password: userPassword, completion: { (user, error) in
            if error == nil {
                let homeStoryboard = UIStoryboard(name: "Stats", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "StatsHomeID") as UIViewController
                self.present(vc, animated: true, completion: nil)
            } else {
                let loginFailedAlert = UIAlertController(title: "Error in logging in.", message:
                    "Sorry, but it seems like there is an error logging you in. Try to put in your information in again, and then try again.", preferredStyle: UIAlertControllerStyle.alert)
                loginFailedAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                self.present(loginFailedAlert, animated: true, completion: nil)
            }
        })
    }
    
}
