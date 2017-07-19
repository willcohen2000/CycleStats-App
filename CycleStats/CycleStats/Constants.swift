//
//  Constants.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Constants {
    
    static let placeholderWhiteColor = UIColor(red: 250, green: 250, blue: 250, alpha: 0.5)
    static let databaseReference = Database.database().reference()
    
    struct SegueIndentifers {
        static var IndividualRideIdentifier = "IndividualRideCell"
        static var NewRideIdentifier = "toNewRideSegue"
    }
    
    struct TimePicker {
        static var hours = [
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12
        ]
        
        static var minutes = [
            5,
            10,
            15,
            20,
            25,
            30,
            35,
            40,
            45,
            50,
            55,
            60
        ]

    }
    
}
