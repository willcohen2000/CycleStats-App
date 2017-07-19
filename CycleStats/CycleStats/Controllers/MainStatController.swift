//
//  MainStatController.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit
import Firebase
import SwiftChart

class MainStatController: UIViewController {
    
    @IBOutlet weak var graphHolderView: UIView!

    @IBOutlet weak var totalMilesLabel: UILabel!
    @IBOutlet weak var averageMilesPerRideLabel: UILabel!
    @IBOutlet weak var numberOfRidesLabel: UILabel!
    @IBOutlet weak var addNewRideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewRideButton.layer.cornerRadius = addNewRideButton.frame.height / 2
        
        graphHolderView.isHidden = true
        let chart = Chart(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: 300))
        let data = [(x: 0.0, y: 0), (x: 3, y: 2.5), (x: 4, y: 2), (x: 5, y: 2.3), (x: 7, y: 3), (x: 8, y: 2.2), (x: 9, y: 2.5), (x: 10, y: 5), (x: 9.5, y: 1), (x: 10, y: 3), (x: 11, y: 5), (x: 12, y: 0.5), (x: 13, y: 8), (x: 14, y: 3), (x: 21, y: 7), (x: 30, y: 7),(x: 33, y: 0), (x: 34, y: 2.5), (x: 35, y: 2.5), (x: 36, y: 2.5), (x: 37, y: 2.5), (x: 38, y: 2.5), (x: 39, y: 2.5), (x: 40, y: 2.5), (x: 41, y: 2.5), (x: 42, y: 2.5), (x: 43, y: 2.5), (x: 44, y: 2.5), (x: 45, y: 2.5), (x: 46, y: 2.5), (x: 47, y: 12), (x: 48, y: 5), (x: 49, y: 2.5), (x: 50, y: 2.5)]
        let series = ChartSeries(data: data)
        series.area = true
        chart.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24,25,26,27,28,29,30]
        chart.yLabelsFormatter = { String(Int(round($1))) + "mi" }
        chart.xLabelsFormatter = { _,_ in "" }
        chart.add(series)
        chart.labelColor = UIColor.white
        chart.gridColor = UIColor.clear
        chart.axesColor = UIColor.clear
        self.view.addSubview(chart)
    }

    @IBAction func addNewRideButtonPressed(_ sender: Any) {
        
    }
    
}




