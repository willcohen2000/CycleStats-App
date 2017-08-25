//
//  CommunityRidesController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/19/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

class CommunityRidesController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Database.database().reference().child("RecentRides").observe(DataEventType.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let ride = Ride(postkey: key, postData: postDict)
                    }
                }
            }
        })
    }

    
}
