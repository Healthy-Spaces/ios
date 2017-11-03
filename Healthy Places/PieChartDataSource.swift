//
//  PieChartGraphDataSource.swift
//  Healthy Places
//
//  Created by Samuel Lichlyter on 10/24/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import UIKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    
    let weekdays = getWeekdays()
    var tracker = getWeeklyTracker()
    var completed: [Bool]?
    
    func isVisible() {
        tracker = getWeeklyTracker()
        completed = self.getCompleted()
        print(completed!)
    }
    
    private func getCompleted() -> [Bool]? {
        var completed = [Bool](repeating: false, count: 7)
        for (key, value) in tracker! {
            if key != "startDate" {
                
                // get index
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE"
                guard let date = formatter.date(from: (key as String)) else { return nil }
                let calendar = Calendar(identifier: .gregorian)
                let index = calendar.component(.weekday, from: date)
                
                completed[index - 1] = (value as? Bool)!
            }
        }
        
        return completed
    }
    
    func numberOfSegments(in pieChartView: ORKPieChartView) -> Int {
        return 7
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        return CGFloat(51.4)
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        return weekdays[index]
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        
        if (completed == nil) {
            return UIColor.red
        }
        
        if !completed![index] {
            return UIColor(traditionalRed: 53, green: 158, blue: 30, alpha: 0.2)
        } else {
            return UIColor(traditionalRed: 53, green: 158, blue: 30, alpha: 1.0)
        }
    }
}
