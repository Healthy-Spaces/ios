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
    
    let one = ORKQuestionStep(identifier: "greenspaceAmount", title: "How would you rate the amount of green space you experienced today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [one]
    
    let two = ORKQuestionStep(identifier: "greenspaceQuality", title: "How would you rate the quality of the green space environment you experienced today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [two]
    
    let three = ORKQuestionStep(identifier: "walkability", title: "How would you rate walkability or ease of walking in areas you visited today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [three]
    
    let four = ORKQuestionStep(identifier: "people", title: "How friendly would you rate the people you came into contact with today?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [four]
    
    let five = ORKQuestionStep(identifier: "airQuality", title: "How would you rate today’s air quality?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [five]
    
    let six = ORKQuestionStep(identifier: "moreTrees", title: "Compared to the areas I visited today, I would like to be around more trees", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [six]
    
    let seven = ORKQuestionStep(identifier: "moreLandscapes", title: "Compared to the areas I visited today, I would like to be around more natural landscapes", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [seven]
    
    
    let eight = ORKQuestionStep(identifier: "morePeople", title: "Compared to the areas I visited today, I would like to be around more friendly people", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [eight]
    
    let nine = ORKQuestionStep(identifier: "morePaths", title: "Compared to the areas I visited today, I want to be in areas with more walking paths and parks", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [nine]
    
    let ten = ORKQuestionStep(identifier: "lessStress", title: "Compared to the areas I visited today, I want to be in areas that are less stressful ", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Everyday", minimumValueDescription: "Very poor"))
    steps += [ten]
    
    return ORKNavigableOrderedTask(identifier: "dailySurvey", steps: steps)
}
