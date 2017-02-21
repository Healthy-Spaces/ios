//
//  GreenspaceSurvey.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 11/23/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation

public var GreenspaceSurvey: ORKNavigableOrderedTask {
    var steps = [ORKStep]()
    
    // Instruction Step
    let instructionStep = ORKInstructionStep(identifier: "instructionStep")
    instructionStep.title = "Greenspace Survey"
    instructionStep.text = "This survey assesses your exposures, uses and perceptions of urban green space (e.g. parks, street trees, open space, lawns, etc.) and how it may impact your health."
    steps += [instructionStep]
    
    let one = ORKQuestionStep(identifier: "greenspaceImpactSlider", title: "To what degree do you think urban green space impacts your health?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "Not at all"))
    steps += [one]
    
    let greenspaceInfluenceChoices = ["Does not influence my health", "Through influencing physical activity", "Through reducing air pollution", "Through reducing noise", "Through reducing heat", "Stress reduction", "Increasing social connections"]
    var greenspaceInfluenceTextChoices = [ORKTextChoice]()
    for index in 0..<greenspaceInfluenceChoices.count {
        let choice = ORKTextChoice(text: greenspaceInfluenceChoices[index], value: index as NSCoding & NSCopying & NSObjectProtocol)
        greenspaceInfluenceTextChoices.append(choice)
    }
    // TODO: include other option
    let greenspaceInfluenceAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: greenspaceInfluenceTextChoices)
    let two = ORKQuestionStep(identifier: "greenspaceInfluenceSelection", title: "How do you think urban green space influences your health? (check all that apply)", answer: greenspaceInfluenceAnswerFormat)
    steps += [two]
    
    let three = ORKQuestionStep(identifier: "yardSpace", title: "To what degree did you consider urban green space when you decided to move to your current home?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "Not at all"))
    steps += [three]
    
    let four = ORKQuestionStep(identifier: "yardSize", title: "Does your home have a yard with green space? If yes what is the size (sq. feet)? (0 for no greenspace)", answer: ORKNumericAnswerFormat(style: .integer, unit: "sq. feet"))
    steps += [four]
    
    let viewChoices = ["No scenic view", "Water", "Green Space", "Urban"]
    var viewTextChoices = [ORKTextChoice]()
    for index in viewChoices.indices {
        let choice = ORKTextChoice(text: viewChoices[index], value: index as NSCoding & NSCopying & NSObjectProtocol)
        viewTextChoices.append(choice)
    }
    // TODO: include other option
    let viewAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: viewTextChoices)
    let five = ORKQuestionStep(identifier: "viewFromHome", title: "Do you have a scenic view from your home?", answer: viewAnswerFormat)
    steps += [five]
    
    let six = ORKQuestionStep(identifier: "viewFromWork", title: "Do you have a scenic view while at work?", answer: viewAnswerFormat)
    steps += [six]
    
    let seven = ORKQuestionStep(identifier: "plantsInHome", title: "How many plants do you have in your home?", answer: ORKNumericAnswerFormat(style: .integer, unit: "plants"))
    steps += [seven]
    
    let greenspaceChoices = ["Parks", "Street trees", "Other street vegetation (e.g. flowers, shrubs, etc.)", "Public lawns/open spaces", "Your yard"]
    var greenspaceTextChoices = [ORKTextChoice]()
    for index in greenspaceChoices.indices {
        let choice = ORKTextChoice(text: greenspaceChoices[index], value: index as NSCoding & NSCopying & NSObjectProtocol)
        greenspaceTextChoices.append(choice)
    }
    // TODO: include other option
    let greenspaceAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: greenspaceTextChoices)
    let eight = ORKQuestionStep(identifier: "mostImportantGreenspace", title: "What do you consider to be the most important type of urban green space?", answer: greenspaceAnswerFormat)
    steps += [eight]
    
    let nine = ORKQuestionStep(identifier: "accessibleParks", title: "How accessible are urban parks around your home?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "Not at all"))
    steps += [nine]
    
    let ten = ORKQuestionStep(identifier: "exercise", title: "Do you routinely exercise?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Everyday", minimumValueDescription: "Not at all"))
    steps += [ten]
    
    let eleven = ORKQuestionStep(identifier: "walkability", title: "How would you rate walkability or ease of walking around your home?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very poor"))
    steps += [eleven]
    
    let twelve = ORKQuestionStep(identifier: "greenspaceRelaxing", title: "To what degree do you find that being in urban green spaces is relaxing and a place to revitalize?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [twelve]
    
    let thirteen = ORKQuestionStep(identifier: "interactingWithNeighbors", title: "To what degree do you find that urban green spaces facilitate social interactions with your neighbors or others?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [thirteen]
    
    let fourteen = ORKQuestionStep(identifier: "airPollution", title: "To what degree do you think that urban green spaces reduce the amount of air pollution you are exposed to?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [fourteen]
    
    let fifteen = ORKQuestionStep(identifier: "dailyGreenspaceAmount", title: "How would you rate the amount of green space you typically experience during your day-to-day activities?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [fifteen]
    
    let sixteen = ORKQuestionStep(identifier: "dailyGreenspaceQuality", title: "How would you rate the quality of the green space environment you typically experience during your day-to-day activities?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [sixteen]
    
    return ORKNavigableOrderedTask(identifier: "greenspaceSurvey", steps: steps)
}
