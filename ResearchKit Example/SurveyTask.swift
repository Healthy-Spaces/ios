//
//  SurveyTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

// MARK: Titles
let enjoyingTitle           =  "Are you enjoying this app?"
let enjoymentTitle          = "How would you rate your enjoyment?"
let enjoymentVerticleTitle  = "How would you rate your enjoyment now that the scale is vertical?"
let locationTitle           = "Where is your favorite university?"
let summaryTitle            = "Thanks!"

// MARK: Descriptions
let maxEnjoymentDesc    = "I love this app!"
let minEnjoymentDesc    = "This is the worst app I've ever used"
let summaryDesc         = "Thank you for participating in this self-serving survey!"

public var SurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()

    // Boolean Step
    let booleanStep = ORKQuestionStep(identifier: "boolean", title: enjoyingTitle, answer: ORKBooleanAnswerFormat())
    booleanStep.isOptional = false
    steps += [booleanStep]
    
    // Horizontal Scale Step
    let horizontalScaleStep = ORKQuestionStep(identifier: "horizontalScale", title: enjoymentTitle, answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: maxEnjoymentDesc, minimumValueDescription: minEnjoymentDesc))
    steps += [horizontalScaleStep]
    
    // Vertical Scale Step
    let verticalScaleStep = ORKQuestionStep(identifier: "verticalScale", title: enjoymentVerticleTitle, answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: true, maximumValueDescription: maxEnjoymentDesc, minimumValueDescription: minEnjoymentDesc))
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
