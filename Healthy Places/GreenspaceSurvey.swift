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
    
    // Greenspace Health Impact
    let one = ORKQuestionStep(identifier: "greenspaceImpactSlider", title: "To what degree do you think urban green space (e.g. parks, street trees, open space, lawns, etc.)  impacts your health?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "Not at all"))
    steps += [one]
    
    // TODO: Greenspace Influence <-- Alternative to ranking?
    let greenspaceInfluenceChoices = ["Does not influence my health", "Through influencing physical activity", "Through reducing air pollution", "Through reducing noise", "Through reducing heat", "Stress reduction", "Increasing social connections"]
    var greenspaceInfluenceTextChoices = [ORKTextChoice]()
    for index in 0..<greenspaceInfluenceChoices.count {
        let choice = ORKTextChoice(text: greenspaceInfluenceChoices[index], value: index as NSCoding & NSCopying & NSObjectProtocol)
        greenspaceInfluenceTextChoices.append(choice)
    }
    let greenspaceInfluenceOtherChoice = ORKTextChoice(text: "Other", value: greenspaceInfluenceChoices.count as NSCoding & NSCopying & NSObjectProtocol)
    greenspaceInfluenceTextChoices.append(greenspaceInfluenceOtherChoice)
    let greenspaceInfluenceAnswerFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: greenspaceInfluenceTextChoices)
    let two = ORKQuestionStep(identifier: "greenspaceInfluenceSelection", title: "How do you think urban green space influences your health? (check all that apply)", answer: greenspaceInfluenceAnswerFormat)
    steps += [two]
    
    // Most important greenspace
    let importantGreenspaceParksChoice = ORKTextChoice(text: "Parks", value: GreenspaceType.parks.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspaceStreetTreesChoice = ORKTextChoice(text: "Street trees", value: GreenspaceType.streetTrees.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspaceOtherVegetationChoice = ORKTextChoice(text: "Other street vegetation (e.g. flowers, shrubs, etc.)", value: GreenspaceType.otherStreetVegetation.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspacePublicLawnsChoice = ORKTextChoice(text: "Public lawns/open spaces", value: GreenspaceType.publicLawnsOpenSpaces.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspaceYourYardChoice = ORKTextChoice(text: "Your yard", value: GreenspaceType.yourYard.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspaceOtherChoice = ORKTextChoice(text: "Other", value: GreenspaceType.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let importantGreenspaceChoices = [importantGreenspaceParksChoice, importantGreenspaceStreetTreesChoice, importantGreenspaceOtherVegetationChoice, importantGreenspacePublicLawnsChoice, importantGreenspaceYourYardChoice, importantGreenspaceOtherChoice]
    let importantGreenspaceFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: importantGreenspaceChoices)
    let importantGreenspaceStep = ORKQuestionStep(identifier: "importantGreenspace", title: "What do you consider to be the most important type of urban green space?", answer: importantGreenspaceFormat)
    steps += [importantGreenspaceStep]
    
    // Yard Space Home Decision
    let three = ORKQuestionStep(identifier: "yardSpace", title: "To what degree did you consider urban green space when you decided to move to your current home?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "Not at all"))
    steps += [three]
    
    // Yard Size
    let four = ORKQuestionStep(identifier: "yardSize", title: "Does your home have a yard with green space? If yes, what is the size?", text: "Enter 0 for no greenspace", answer: ORKNumericAnswerFormat(style: .integer, unit: "sq. feet"))
    steps += [four]
    
    // Home View
    let viewChoices = ["No view", "Water", "Lawn", "Trees", "Park", "Mixed green space", "Urban"]
    var viewTextChoices = [ORKTextChoice]()
    for index in viewChoices.indices {
        let choice = ORKTextChoice(text: viewChoices[index], value: index as NSCoding & NSCopying & NSObjectProtocol)
        viewTextChoices.append(choice)
    }
    let homeViewOtherChoice = ORKTextChoice(text: "Other", value: viewChoices.count as NSCoding & NSCopying & NSObjectProtocol)
    viewTextChoices.append(homeViewOtherChoice)
    let viewAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: viewTextChoices)
    let five = ORKQuestionStep(identifier: "viewFromHome", title: "Do you have a scenic view from your home?", answer: viewAnswerFormat)
    steps += [five]
    
    // Image capture from home
    let imageExplanationStep = ORKInstructionStep(identifier: "imageExplanation")
    imageExplanationStep.title = "If you are taking this survey at home, please take a picture out your main living room window.  This will be used to asses visual exposure to green space."
    steps += [imageExplanationStep]
    let imageFromHome = ORKImageCaptureStep(identifier: "imageFromHome")
    steps += [imageFromHome]
    
    // Scenic view from work
    let six = ORKQuestionStep(identifier: "viewFromWork", title: "Do you have a scenic view while at work?", answer: viewAnswerFormat) // Used from Home View above
    steps += [six]
    
    // Plants in home
    let seven = ORKQuestionStep(identifier: "plantsInHome", title: "How many plants do you have in your home?", answer: ORKNumericAnswerFormat(style: .integer, unit: "plants"))
    steps += [seven]
    
    // Greenspace proximity
    let greenspaceProximityYesChoice = ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol)
    let greenspaceProximityNoChoice = ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    let greenspaceProximityDontKnowChoice = ORKTextChoice(text: "Don't know", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    let greenspaceProximityChoices = [greenspaceProximityYesChoice, greenspaceProximityNoChoice, greenspaceProximityDontKnowChoice]
    let greenspaceProximityFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: greenspaceProximityChoices)
    let greenspaceProximityStep = ORKQuestionStep(identifier: "greenspaceProximity", title: "Is there a green open space (large park or comparable area) or forested area within 5-10 minute walking distance from where you live?", answer: greenspaceProximityFormat)
    steps += [greenspaceProximityStep]
    
    // Routinely Exercise?
    let ten = ORKQuestionStep(identifier: "exercise", title: "Do you routinely exercise (e.g. walk, run, bike, or play) in parks, forests, or other green space areas?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Everyday", minimumValueDescription: "Not at all"))
    steps += [ten]
    
    // Greenspaces relaxing
    let twelve = ORKQuestionStep(identifier: "greenspaceRelaxing", title: "To what degree do you find that being in urban green spaces is relaxing and a place to revitalize?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [twelve]
    
    // Greenspace social interactions
    let thirteen = ORKQuestionStep(identifier: "interactingWithNeighbors", title: "To what degree do you find that urban green spaces facilitate social interactions with your neighbors or others?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [thirteen]
    
    // air pollution
    let fourteen = ORKQuestionStep(identifier: "airPollution", title: "To what degree do you think that urban green spaces reduce the amount of air pollution you are exposed to?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [fourteen]
    
    // Daily greenspace exposure
    let fifteen = ORKQuestionStep(identifier: "dailyGreenspaceAmount", title: "How would you rate the amount of green space you typically experience during your day-to-day activities?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [fifteen]
    
    // Daily greenspace quality
    let sixteen = ORKQuestionStep(identifier: "dailyGreenspaceQuality", title: "How would you rate the quality of the green space environment you typically experience during your day-to-day activities?", answer: ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very high", minimumValueDescription: "Very low"))
    steps += [sixteen]
    
    // Break Step
    let breakStep = ORKInstructionStep(identifier: "breakStep")
    breakStep.text = "Now we are going to ask some questions and ask you to complete some games that test outcomes that may be associated with green space exposures."
    steps += [breakStep]
    
    // General Health
    let healthExcellentChoice = ORKTextChoice(text: "Excellent", value: Health.excellent.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let healthVeryGoodChoice = ORKTextChoice(text: "Very good", value: Health.veryGood.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let healthGoodChoice = ORKTextChoice(text: "Good", value: Health.good.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let healthFairChoice = ORKTextChoice(text: "Fair", value: Health.fair.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let healthPoorChoice = ORKTextChoice(text: "Poor", value: Health.poor.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let healthChoices = [healthExcellentChoice, healthVeryGoodChoice, healthGoodChoice, healthFairChoice, healthPoorChoice]
    let healthFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: healthChoices)
    let healthStep = ORKQuestionStep(identifier: "generalHealth", title: "In general, would you say that your health is:", answer: healthFormat)
    steps += [healthStep]
    
    // TODO: Last 4 weeks feeling
    
    // Tower of Hanoi
    let hanoiStep = ORKTowerOfHanoiStep(identifier: "hanoi")
    steps += [hanoiStep]
    
    // Spatial Memory
    let spatialMemoryStep = ORKSpatialSpanMemoryStep(identifier: "spatialMemory")
    steps += [spatialMemoryStep]
    
    // Paced Serial Addition Test (PSAT)
    let psatStep = ORKPSATStep(identifier: "psat")
    steps += [psatStep]
    
    // Reaction Time
    let reactionTimeStep = ORKReactionTimeStep(identifier: "reactionTime")
    steps += [reactionTimeStep]
    
    return ORKNavigableOrderedTask(identifier: "greenspaceSurvey", steps: steps)
}
