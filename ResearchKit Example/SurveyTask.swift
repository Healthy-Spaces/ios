//
//  SurveyTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    // Instruction Step
    let instructionStep = ORKInstructionStep(identifier: "instructionStep")
    instructionStep.title = "Generic Study"
    instructionStep.text = "This is a basic example of some of the tasks included in ResearchKit"
    steps += [instructionStep]

    // Boolean Step
    let booleanStep = ORKQuestionStep(identifier: "boolean", title: booleanTitle, answer: ORKBooleanAnswerFormat())
    booleanStep.isOptional = false
    steps += [booleanStep]
    
    // Horizontal Scale Step
    let horizontalScaleStep = ORKQuestionStep(identifier: "horizontalScale", title: horizontalSliderTitle, answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: maxEnjoymentDesc, minimumValueDescription: minEnjoymentDesc))
    steps += [horizontalScaleStep]
    
    // Vertical Scale Step
    let verticalScaleStep = ORKQuestionStep(identifier: "verticalScale", title: verticalSliderTitle, answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: true, maximumValueDescription: maxEnjoymentDesc, minimumValueDescription: minEnjoymentDesc))
    steps += [verticalScaleStep]
    
    // Number of places lived step
    let placesLivedFormat = ORKNumericAnswerFormat.integerAnswerFormat(withUnit: "places lived")
    placesLivedFormat.minimum = 0
    placesLivedFormat.maximum = 10
    let numPlacesLivedStep = ORKQuestionStep(identifier: "numLocationsLived", title: numPlacesLivedTitle, answer: placesLivedFormat)
    steps += [numPlacesLivedStep]
    
    // Location Step
    let locationAnswerFormat = ORKLocationAnswerFormat()
    locationAnswerFormat.useCurrentLocation = true
    let locationStep = ORKQuestionStep(identifier: "location", title: locationTitle, answer: locationAnswerFormat)
    steps += [locationStep]

    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
