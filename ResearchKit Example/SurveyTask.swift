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
    
    // Location Step
    let locationStep = ORKQuestionStep(identifier: "location", title: locationTitle, answer: ORKLocationAnswerFormat())
    steps += [locationStep]
    
    // Summary Step
    let summaryStep = ORKInstructionStep(identifier: "summary")
    summaryStep.title = summaryTitle
    summaryStep.text  = summaryDesc
    steps += [summaryStep]

    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
