//
//  SignUpController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSForegroundColorAttributeName: Constants.placeholderWhiteColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSForegroundColorAttributeName: Constants.placeholderWhiteColor])
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                     attributes: [NSForegroundColorAttributeName: Constants.placeholderWhiteColor])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let userPassword: String = passwordTextField.text!
        let userConfirmPassword: String = confirmPasswordTextField.text!
        let userEmail: String = emailTextField.text!
        
        if (userPassword != userConfirmPassword) {
            let passwordsNotEqualAlert = UIAlertController(title: "Your passwords are not the same.", message:
                "Please repeat your password and confirm password, as they do not seem to be equal.", preferredStyle: UIAlertControllerStyle.alert)
            passwordsNotEqualAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(passwordsNotEqualAlert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
                if let error = error {
                    MainFunctions.showError(error: error)
                    return
                }
                let homeStoryboard = UIStoryboard(name: "Stats", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "StatsHomeID") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }
        }

    }
    
    @IBAction func backToHomePageButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
