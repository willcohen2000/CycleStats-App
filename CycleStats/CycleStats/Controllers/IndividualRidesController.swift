//
//  IndividualRidesController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase

class IndividualRidesController: UIViewController, UITableViewDelegate, UITableViewDataSource, pickIndividualRideDelegate {

    @IBOutlet weak var individualRidesTableView: UITableView!
    
    var individualRides = [Ride]()
    var selectedRide: Ride?
    
    var delegate: pickIndividualRideDelegate?
    
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
        let individualRide = individualRides[indexPath.row]
        if let cell = individualRidesTableView.dequeueReusableCell(withIdentifier: Constants.SegueIndentifers.IndividualRideIdentifier) as? IndividualRideCell {
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            cell.configureCell(ride: individualRide)
            return cell
        } else {
            return IndividualRideCell()
        }
    }

    @IBAction func backArrowButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pickIndividualRide(_ ride: Ride) {
        self.selectedRide = ride
        self.performSegue(withIdentifier: Constants.SegueIndentifers.goToIndividualRideSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.SegueIndentifers.goToIndividualRideSegue) {
            if let nextVC = segue.destination as? ViewIndividualRideController {
                nextVC.ride = self.selectedRide
            }
        }
    }
    
}



