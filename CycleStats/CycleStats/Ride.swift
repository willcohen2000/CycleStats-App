//
//  Ride.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation

class Ride {
    
    var rideName: String!
    var rideDescription: String!
    var rideDate: Date!
    var rideLenthInMiles: Float!
    
    init(rideName: String, rideDescription: String, rideDate: Date, rideLengthInMiles: Float) {
        self.rideName = rideName
        self.rideDescription = rideDescription
        self.rideDate = rideDate
        self.rideLenthInMiles = rideLengthInMiles
    }
    
}
