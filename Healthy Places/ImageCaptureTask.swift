//
//  ImageCaptureTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var ImageCaptureTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let imageCaptureStep = ORKImageCaptureStep(identifier: "imageCaptureStep")
    steps += [imageCaptureStep]

    return ORKOrderedTask(identifier: "imageCaptureTask", steps: steps)
}
