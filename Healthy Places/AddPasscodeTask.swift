//
//  AddPasscodeTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/22/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var AddPasscodeTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let passcodeStep = ORKPasscodeStep(identifier: "addPasscode")
    passcodeStep.passcodeType = ORKPasscodeType.type6Digit
    steps += [passcodeStep]
    
    return ORKOrderedTask(identifier: "addPasscode", steps: steps)
}
