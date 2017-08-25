//
//  Firebase+Service.swift
//  CycleStats
//
//  Created by Will Cohen on 7/19/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    static func postNewRideToFirebase(ride: Ride, user: User, completionHandler: @escaping (_ success: Bool) -> Void) {
        let ridesReference = Constants.databaseReference.child("Rides")
        let recentRidesReference = Constants.databaseReference.child("RecentRides")
        
        let rideDictionary = [
            "rideName": ride.rideName,
            "rideDate": MainFunctions.formatRideDate(rideDate: ride.rideDate),
            "rideTime": ride.rideTime,
            "rideLength": ride.rideLenthInMiles
        ] as [String : Any]
        
        recentRidesReference.childByAutoId().updateChildValues(rideDictionary)
        ridesReference.child(user.uid).childByAutoId().updateChildValues(rideDictionary) { (error, ref) -> Void in
            if (error != nil) {
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }
    }
    
    static func retrieveRides(user: User, completionHandler: @escaping (_ returnRides: [Ride]) -> Void) {
        let ridesReference = Constants.databaseReference.child("Rides")
        var rides = [Ride]()
        ridesReference.child(user.uid).observeSingleEvent(of: .value, with: { snapshot in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let ride = Ride(postkey: key, postData: postDict)
                        rides.append(ride)
                    }
                }
            }
            completionHandler(rides)
        })
    }
    

    
}
