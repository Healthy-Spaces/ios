//
//  DailySurvey.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 11/23/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation

public var DailySurvey: ORKNavigableOrderedTask {
    var steps = [ORKStep]()
    
    // Instruction Step
    let instructionStep = ORKInstructionStep(identifier: "instructionStep")
    instructionStep.title = "Daily Survey"
    instructionStep.text = "These short questions will assess your exposures, uses, and perceptions of your green space exposures today."
    steps += [instructionStep]
    
    let one = ORKQuestionStep(identifier: "greenspaceAmount", title: "How would you rate the amount of green space you experienced today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [one]
    
    let two = ORKQuestionStep(identifier: "greenspaceQuality", title: "How would you rate the quality of the green space environment you experienced today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [two]
    
    let greenspaceUseStep = ORKQuestionStep(identifier: "greenspaceUse", title: "How would you rate your use of the green space today (e.g. for exercise, relaxation, etc.)", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [greenspaceUseStep]
    
    // TODO: How do you feel today?
    
    return ORKNavigableOrderedTask(identifier: "dailySurvey", steps: steps)
}
