//
//  HanoiTask.swift
//  Healthy Places
//
//  Created by Samuel Lichlyter on 9/22/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var HanoiTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let hanoiStep = ORKTowerOfHanoiStep(identifier: "hanoi")
    steps += [hanoiStep]
    
    return ORKOrderedTask(identifier: "hanoiTask", steps: steps)
}
