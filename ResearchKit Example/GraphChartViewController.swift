//
//  GraphChartViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit

class GraphChartViewController: UIViewController {

    @IBOutlet weak var lineGraphView: ORKLineGraphChartView!
    @IBOutlet weak var pieGraphView: ORKPieChartView!
    @IBOutlet weak var discreteGraphView: ORKDiscreteGraphChartView!
    
    let graphChartDataSource = GraphChartDataSource()
    let pieChartDataSource = PieChartDataSource()
    let discreteChartDataSource = GraphChartDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Line View Required
        lineGraphView.dataSource = graphChartDataSource
        
        // Line View Optional
        lineGraphView.showsHorizontalReferenceLines = true
        lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.axisColor = UIColor.white()
        lineGraphView.verticalAxisTitleColor = UIColor.orange()
        lineGraphView.showsHorizontalReferenceLines = true
        lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.scrubberLineColor = UIColor.red()
        
        
        // Pie Chart Required
        pieGraphView.dataSource = pieChartDataSource
        
        // Pie Chart Optional
        pieGraphView.showsTitleAboveChart = false
        pieGraphView.showsPercentageLabels = true
        pieGraphView.drawsClockwise = true
        pieGraphView.titleColor = UIColor.purple()
        pieGraphView.textColor = UIColor.purple()
        pieGraphView.title = "Weekly"
        pieGraphView.text = "Report"
        pieGraphView.lineWidth = 10
        pieGraphView.showsPercentageLabels = true
        
        
        // Discrete Graph Required
        discreteGraphView.dataSource = discreteChartDataSource
        
        // Discrete Graph Optional
        discreteGraphView.showsVerticalReferenceLines = true
        discreteGraphView.drawsConnectedRanges = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
