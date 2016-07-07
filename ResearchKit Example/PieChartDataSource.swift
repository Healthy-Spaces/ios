//
//  PieChartDataSource.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    
    let colors = [
        UIColor(red: 217/225, green: 217/255, blue: 217/225, alpha: 1),
        UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1),
        UIColor(red: 244/255, green: 200/255, blue: 74/255, alpha: 1)
    ]
    
    let values = [60.0, 25.0, 15.0]
    
    // Required Methods
    func numberOfSegments(in pieChartView: ORKPieChartView) -> Int {
        return colors.count
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        return CGFloat(values[index])
    }
    
    // Optional Methods
    func pieChartView(_ pieChartView: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        return colors[index]
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        switch index {
        case 0:
            return "Steps taken"
        case 1:
            return "Tasks completed"
        case 2:
            return "Surveys completed"
        default:
            return "task \(index + 1)"
        }
    }
}
