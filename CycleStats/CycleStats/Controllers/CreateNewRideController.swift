//
//  CreateNewRideController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/19/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Foundation
import Firebase

protocol CreatedNewRideDelegate {
    func createdNewRide()
}

class CreateNewRideController: UIViewController {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var numberOfMilesLabel: UITextField!
    @IBOutlet weak var hoursPickerView: UIPickerView!
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var rideNameLabel: UITextField!
    @IBOutlet weak var saveRideButton: UIButton!
    
    let invalidRedColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
    var saveRideIsLoading: Bool = false
    var delegate: CreatedNewRideDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hoursPickerView.delegate = self
        hoursPickerView.dataSource = self
        minutesPickerView.delegate = self
        minutesPickerView.dataSource = self
        
        saveRideButton.layer.cornerRadius = saveRideButton.frame.height / 2
        
        MainFunctions.textFieldCornerRadius(label: numberOfMilesLabel, cornerRadius: 5.0)
        MainFunctions.textFieldCornerRadius(label: rideNameLabel, cornerRadius: 5.0)
        MainFunctions.viewConfigure(view: holderView, color: UIColor.white, width: 1.0, cornerRadius: 10.0)
    }

    @IBAction func saveRideButtonPressed(_ sender: Any) {
        if (!saveRideIsLoading)  {
            saveRideIsLoading = true
            guard let miles = Float(numberOfMilesLabel.text!) else {
                invalidTextFieldReference(textField: numberOfMilesLabel)
                return
            }
            guard let rideName = rideNameLabel.text else {
                invalidTextFieldReference(textField: rideNameLabel)
                return
            }
            let rideTime = "\(hoursPickerView.selectedRow(inComponent: 0))hrs : \(minutesPickerView.selectedRow(inComponent: 0))mins"
            
            let newRide = Ride(rideName: rideName, rideDate: Date(), rideLengthInMiles: miles, rideTime: rideTime)
            FirebaseService.postNewRideToFirebase(ride: newRide, user: Auth.auth().currentUser!, completionHandler: { (success) -> Void in
                if (success) {
                    let totalMiles = UserDefaults.standard.float(forKey: "totalMiles")
                    UserDefaults.standard.set((totalMiles + miles), forKey: "totalMiles")
                    let totalRides = UserDefaults.standard.integer(forKey: "totalRides")
                    UserDefaults.standard.set((totalRides + 1), forKey: "totalRides")
                    if let delegate = self.delegate {
                        delegate.createdNewRide()
                    }
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let firebasePostError = UIAlertController(title: "Unable to save ride.", message:
                        "It seems like we cannot successfuly save your ride at this time. This may be due to lack of internet connection. Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
                    firebasePostError.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                    self.present(firebasePostError, animated: true, completion: nil)
                }
            })
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CreateNewRideController {
    func invalidTextFieldReference(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = invalidRedColor.cgColor
    }
}

extension CreateNewRideController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) {
            return Constants.TimePicker.hours.count
        } else {
            return Constants.TimePicker.minutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView.tag == 0) {
            let hoursString = NSAttributedString(string: "\(Constants.TimePicker.hours[row])", attributes: [NSForegroundColorAttributeName : UIColor.white])
            return hoursString
        } else {
            let minutesString = NSAttributedString(string: "\(Constants.TimePicker.minutes[row])", attributes: [NSForegroundColorAttributeName : UIColor.white])
            return minutesString
        }
    }

}



