//
//  PieChartViewController.swift
//  Healthy Places
//
//  Created by Samuel Lichlyter on 10/24/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import UIKit
import CoreGraphics
import ResearchKit

class PieChartViewController: UIViewController {
    @IBOutlet weak var pieChartView: ORKPieChartView!
    
    var dataSource = PieChartDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.showsPercentageLabels = false
        pieChartView.noDataText = "Complete Daily Surveys to fill up the graph!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSource.isVisible()
        pieChartView.dataSource = dataSource
    }
}
