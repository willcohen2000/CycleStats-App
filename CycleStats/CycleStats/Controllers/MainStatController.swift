//
//  MainStatController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftChart
import SwiftKeychainWrapper

class MainStatController: UIViewController, CreatedNewRideDelegate {
    
    @IBOutlet weak var graphHolderView: UIView!
    @IBOutlet weak var graphLabel: UILabel!

    @IBOutlet weak var totalMilesLabel: UILabel!
    @IBOutlet weak var averageMilesPerRideLabel: UILabel!
    @IBOutlet weak var numberOfRidesLabel: UILabel!
    @IBOutlet weak var addNewRideButton: UIButton!
    
    var mainChart = Chart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewRideButton.layer.cornerRadius = addNewRideButton.frame.height / 2
        
        graphHolderView.isHidden = true
        
        let chart = Chart(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 300))
        mainChart = chart
        var data: [(x: Float, y: Float)] = []
        
        FirebaseService.retrieveRides(user: Auth.auth().currentUser!) { (rides) in
            if (rides.count > 2) {
                var x = 0
                for (ride) in rides {
                    x += 1
                    data.append((x: Float(x), y: ride.rideLenthInMiles))
                }
                let series = ChartSeries(data: data)
                series.area = true
                chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24,25,26,27,28,29,30]
                chart.xLabelsFormatter = { _,_ in "" }
                chart.add(series)
                chart.labelColor = UIColor.white
                chart.gridColor = UIColor.clear
                chart.axesColor = UIColor.clear
                self.graphLabel.isHidden = true
                self.view.addSubview(chart)
            } else {
                self.graphLabel.isHidden = false
            }
        }
        
       
    }
    
    func createdNewRide() {
        
        self.mainChart.removeFromSuperview()
        
        let chart = Chart(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 300))
        mainChart = chart
        var data: [(x: Float, y: Float)] = []
        
        FirebaseService.retrieveRides(user: Auth.auth().currentUser!) { (rides) in
            if (rides.count != 0) {
                var x = 0
                for (ride) in rides {
                    x += 1
                    data.append((x: Float(x), y: ride.rideLenthInMiles))
                }
                let series = ChartSeries(data: data)
                series.area = true
                chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24,25,26,27,28,29,30]
                chart.xLabelsFormatter = { _,_ in "" }
                chart.add(series)
                chart.labelColor = UIColor.white
                chart.gridColor = UIColor.clear
                chart.axesColor = UIColor.clear
                self.graphLabel.isHidden = true
                self.view.addSubview(chart)
            } else {
                self.graphLabel.isHidden = true
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.SegueIndentifers.NewRideIdentifier) {
            if let nextVC = segue.destination as? CreateNewRideController {
                nextVC.delegate = self
            }
        } else if segue.identifier == "toIndividualRidesSegue" {
            if let nextVC = segue.destination as? IndividualRidesController {
            }
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let signOutAlert = UIAlertController(title: "Are you sure you want to sign out?", message:
            "Please confirm that you want to log out of Cycle Stats.", preferredStyle: UIAlertControllerStyle.alert)
        signOutAlert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) in
            let _ = KeychainWrapper.standard.removeObject(forKey: "uid")
            let homeStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "landingPage") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }))
        signOutAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in}))
        self.present(signOutAlert, animated: true, completion: nil)
    }
    
    
    
}




