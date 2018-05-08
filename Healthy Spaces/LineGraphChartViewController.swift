//
//  GraphChartViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/5/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import CoreGraphics
import ResearchKit

class GraphChartViewController: UIViewController {

    @IBOutlet weak var lineGraphView: ORKLineGraphChartView!
    
    let graphChartDataSource = GraphChartDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Line View Required
        lineGraphView.dataSource = graphChartDataSource
        
        // Line View Optional
        lineGraphView.showsHorizontalReferenceLines = false
        lineGraphView.showsVerticalReferenceLines = false
        lineGraphView.axisColor = UIColor(traditionalRed: 0xAF, green: 0x29, blue: 0x2E, alpha: 1.0)
        lineGraphView.verticalAxisTitleColor = UIColor(traditionalRed: 0xAF, green: 0x29, blue: 0x2E, alpha: 1.0)
        lineGraphView.scrubberLineColor = UIColor(traditionalRed: 0xAF, green: 0x29, blue: 0x2E, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
