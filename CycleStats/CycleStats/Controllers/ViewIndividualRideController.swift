//
//  ViewIndividualRideController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/19/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class ViewIndividualRideController: UIViewController {

    @IBOutlet weak var rideMilesLabel: UILabel!
    @IBOutlet weak var rideTimeLabel: UILabel!
    @IBOutlet weak var rideDateLabel: UILabel!
    @IBOutlet weak var rideNameLabel: UILabel!
    
    @IBOutlet weak var userAverageMilesLabel: UILabel!
    @IBOutlet weak var userPlusMinusLabel: UILabel!
    
    @IBOutlet weak var holderView: UIView!
    
    var ride: Ride!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MainFunctions.viewConfigure(view: holderView, color: UIColor.white, width: 1.0, cornerRadius: 10.0)
        
        rideMilesLabel.text = String(ride.rideLenthInMiles)
        rideTimeLabel.text = ride.rideTime
        rideDateLabel.text = ride.rideDateFormatted
        rideNameLabel.text = ride.rideName
        
        let averageMilesPerRide = (UserDefaults.standard.float(forKey: "totalMiles") / Float(UserDefaults.standard.integer(forKey: "totalRides")))
        
        if ((ride.rideLenthInMiles - averageMilesPerRide) < 0) {
            self.userPlusMinusLabel.text = String(format: "%.2f", (ride.rideLenthInMiles - averageMilesPerRide))
        } else {
            self.userPlusMinusLabel.text = "+\(String(format: "%.2f", (ride.rideLenthInMiles - averageMilesPerRide)))"
        }
        
        userAverageMilesLabel.text = String(format: "%.2f", averageMilesPerRide)
        
    }

    @IBAction func backArrowButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
