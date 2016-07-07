//
//  GraphChartDataSource.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class GraphChartDataSource: NSObject, ORKGraphChartViewDataSource {
    
    var plotPoints = [
            [
                ORKRangedPoint(value: 200),
                ORKRangedPoint(value: 450),
                ORKRangedPoint(value: 500),
                ORKRangedPoint(value: 250),
                ORKRangedPoint(value: 300),
                ORKRangedPoint(value: 600),
                ORKRangedPoint(value: 300),
            ], [
                ORKRangedPoint(value: 100),
                ORKRangedPoint(value: 350),
                ORKRangedPoint(value: 400),
                ORKRangedPoint(value: 150),
                ORKRangedPoint(value: 200),
                ORKRangedPoint(value: 500),
                ORKRangedPoint(value: 400),
            ]
    ]
    
    
    // Required Methods
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        return plotPoints[plotIndex][pointIndex]
    }
    
    // Optional Methods
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func maximumValue(for graphChartView: ORKGraphChartView) -> CGFloat {
        return 1000
    }
    
    func minimumValue(for graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        if plotIndex == 0 {
            return UIColor.purple()
        } else {
            return UIColor.blue()
        }
    }
}
