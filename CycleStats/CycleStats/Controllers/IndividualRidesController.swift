//
//  IndividualRidesController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

class IndividualRidesController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var individualRidesTableView: UITableView!
    
    var individualRides = [Ride]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        individualRidesTableView.delegate = self
        individualRidesTableView.dataSource = self
        individualRidesTableView.backgroundColor = UIColor.clear
        
        FirebaseService.retrieveRides(user: Auth.auth().currentUser!) { (rides) in
            self.individualRides = rides
            self.individualRidesTableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return individualRides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = individualRidesTableView.dequeueReusableCell(withIdentifier: Constants.SegueIndentifers.IndividualRideIdentifier) as? IndividualRideCell {
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            return IndividualRideCell()
        }
    }

    @IBAction func backArrowButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newRideButtonPressed(_ sender: Any) {
        
    }
    
}



