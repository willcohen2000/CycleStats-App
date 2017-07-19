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
    var rideDate: Date!
    var rideTime: String!
    var rideLenthInMiles: Float!
    var rideDateFormatted: String!
    
    init(rideName: String, rideDate: Date, rideLengthInMiles: Float, rideTime: String) {
        self.rideName = rideName
        self.rideDate = rideDate
        self.rideLenthInMiles = rideLengthInMiles
        self.rideTime = rideTime
    }
    
    init(postkey: String, postData: Dictionary<String, AnyObject>) {
        
        if let rideName = postData["rideName"] as? String {
            self.rideName = rideName
        }
        
        if let rideTime = postData["rideTime"] as? String {
            self.rideTime = rideTime
        }
        
        if let rideLength = postData["rideLength"] as? Float {
            self.rideLenthInMiles = rideLength
        }
        
        if let rideTime = postData["rideDate"] as? String {
            self.rideTime = rideTime
        }
    
    }
    
}
