//
//  LandingPageController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LandingPageController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedUser = KeychainWrapper.standard.string(forKey: "uid") {
            Auth.auth().addStateDidChangeListener({ (auth, savedUser) in
                if savedUser != nil {
                    let homeStoryboard = UIStoryboard(name: "Stats", bundle: nil)
                    let vc = homeStoryboard.instantiateViewController(withIdentifier: "StatsHomeID") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            })
        }
        
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
                KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                let homeStoryboard = UIStoryboard(name: "Stats", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "StatsHomeID") as UIViewController
                self.present(vc, animated: true, completion: nil)
            } else {
                if let error = error {
                    switch (error.localizedDescription) {
                    case "The email address is badly formatted.":
                            let invalidEmailAlert = UIAlertController(title: "Invalid Email", message:
                                "It seems like you have put in an invalid email.", preferredStyle: UIAlertControllerStyle.alert)
                            invalidEmailAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                            self.present(invalidEmailAlert, animated: true, completion: nil)
                            break;
                        case "The password is invalid or the user does not have a password.":
                            let wrongPasswordAlert = UIAlertController(title: "Wrong Password", message:
                                "It seems like you have entered the wrong password.", preferredStyle: UIAlertControllerStyle.alert)
                            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                            self.present(wrongPasswordAlert, animated: true, completion: nil)
                            break;
                        case "There is no user record corresponding to this identifier. The user may have been deleted.":
                            let wrongPasswordAlert = UIAlertController(title: "No Account Found", message:
                                "We couldn't find an account that corresponds to that email. Do you want to create an account?", preferredStyle: UIAlertControllerStyle.alert)
                            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                            wrongPasswordAlert.addAction(UIAlertAction(title: "Create Account", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                                self.performSegue(withIdentifier: "goToCreateAccount", sender: nil)
                            }))
                            self.present(wrongPasswordAlert, animated: true, completion: nil)
                            break;
                        default:
                            let loginFailedAlert = UIAlertController(title: "Error Logging In", message:
                                "There was an error logging you in. Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
                            loginFailedAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                            self.present(loginFailedAlert, animated: true, completion: nil)
                            break;
                    }
                    
                }
            }
        })
    }
    
}





