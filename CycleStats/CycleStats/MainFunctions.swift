//
//  MainFunctions.swift
//  CycleStats
//
//  Created by Will Cohen on 7/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class MainFunctions {
    
    static func showError(error: Error) {
        print("===============================================")
        print(error.localizedDescription)
        print("===============================================")
    }
    
    static func textFieldCornerRadius(label: UITextField, cornerRadius: Float) {
        label.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    static func formatRideDate(rideDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = .long
        var rideDateFormatted = formatter.string(from: rideDate)
        if let fullDateFormatted = rideDateFormatted.range(of: "at") {
            rideDateFormatted.removeSubrange(fullDateFormatted.lowerBound..<rideDateFormatted.endIndex)
        }
        return rideDateFormatted
    }
    
    static func viewConfigure(view: UIView, color: UIColor, width: Float, cornerRadius: Float) {
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = CGFloat(width)
    }
    
}
