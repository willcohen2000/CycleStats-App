//
//  IndividualRideCell.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class IndividualRideCell: UITableViewCell {

    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var rideNameLabel: UILabel!
    @IBOutlet weak var rideInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    var ride: Ride!
    
    func configureCell(ride: Ride) {
        self.ride = ride
        rideNameLabel.text = ride.rideName
        rideInfoLabel.text = "\(ride.rideLenthInMiles!) mi - \(ride.rideDateFormatted!)"
    }
    
    @IBAction func cellButtonPressed(_ sender: Any) {
        
    }
    

}
