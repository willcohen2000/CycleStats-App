//
//  IndividualRidesController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class IndividualRidesController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var individualRidesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        individualRidesTableView.delegate = self
        individualRidesTableView.dataSource = self
        individualRidesTableView.backgroundColor = UIColor.clear
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = individualRidesTableView.dequeueReusableCell(withIdentifier: Constants.SegueIndentifers.IndividualRideIdentifier) as? IndividualRideCell {
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            return IndividualRideCell()
        }
    }

}
