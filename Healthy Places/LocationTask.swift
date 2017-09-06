//
//  LocationTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 8/25/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var LocationTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
//    let locationAnswerFormat = ORKLocationAnswerFormat()
//    locationAnswerFormat.useCurrentLocation = false
    let locationStep = ORKQuestionStep(identifier: "location", title: locationTitle, answer: ORKLocationAnswerFormat())
    steps += [locationStep]
    
    return ORKOrderedTask(identifier: "LocationTask", steps: steps)
}
