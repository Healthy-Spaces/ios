//
//  GraphChartDataSource.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class GraphChartDataSource: NSObject, ORKGraphChartViewDataSource {
    
    var plotPoints = Array<Array<ORKRangedPoint>>()
    
    override init() {
        super.init()
        
        // turn greenspace JSON into plotPoints
        do {
            let path = Bundle.main.url(forResource: "greenspace", withExtension: "json")
            let jsonData = try Data(contentsOf: path!)
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            let greenspace = jsonResult["greenspace"] as? Array<Array<Int>>
            for plot in greenspace! {
                var nums = Array<ORKRangedPoint>()
                for num in plot {
                    let point = ORKRangedPoint(value: CGFloat(num))
                    nums.append(point)
                }
                plotPoints.append(nums)
            }
        } catch let error {
            print("Unresolved Greenspace JSON Serialization Error: \(error)")
        }
    }
    
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
        var largestNode: CGFloat! = 0
        for plot in plotPoints {
            for node in plot {
                if node.maximumValue > largestNode {
                    largestNode = node.maximumValue
                    print("Largest: \(largestNode)")
                }
            }
        }
        
        return largestNode + largestNode * 0.35
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
            return UIColor(traditionalRed: 53, green: 158, blue: 30, alpha: 1.0) // These two…
        } else {
            return UIColor(traditionalRed: 0x35, green: 0x9E, blue: 0x1E, alpha: 0.5) // …are the same color with different transparency
        }
    }
}
