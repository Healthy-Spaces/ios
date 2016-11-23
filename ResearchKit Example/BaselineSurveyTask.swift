//
//  BaselineSurveyTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 9/29/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation

public var BaselineSurveyTask: ORKNavigableOrderedTask {
    var steps = [ORKStep]()
    
    // Instruction Step
    let instructionStep = ORKInstructionStep(identifier: "instructionStep")
    instructionStep.title = "Baseline Survey"
    instructionStep.text = "We begin with asking you some basic socio-demographic questions to help us better understand who you are and how these characteristics may influence your exposures to urban environments."
    steps += [instructionStep]
    
    // Ethnicity
    let caucasionChoice = ORKTextChoice(text: "Caucasian", value: Ethnicity.caucasion.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let blackChoice = ORKTextChoice(text: "Black", value: Ethnicity.black.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let filipinoChoice = ORKTextChoice(text: "Filipino", value: Ethnicity.filipino.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let chineseChoice = ORKTextChoice(text: "Chinese (Hong Kong/Taiwan/Mainland China)", value: Ethnicity.chinese.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let nativeAmericanChoice = ORKTextChoice(text: "Native American", value: Ethnicity.nativeAmerican.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let hispanicChoice = ORKTextChoice(text: "Hispanic", value: Ethnicity.hispanic.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let southAsianChoice = ORKTextChoice(text: "South Asian (Indian Continent)", value: Ethnicity.southAsian.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let japaneseChoice = ORKTextChoice(text: "Japanese", value: Ethnicity.japanese.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let middleEasternChoice = ORKTextChoice(text: "Middle Eastern", value: Ethnicity.middleEastern.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let southeastAsianChoice = ORKTextChoice(text: "South East Asian (Cambodia/Vietnam/Laos/Malaysia/Thai)", value: Ethnicity.southeastAsian.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let unknownChoice = ORKTextChoice(text: "Unknown", detailText: nil, value: Ethnicity.unknown.rawValue as NSCoding & NSCopying & NSObjectProtocol, exclusive: true)
    let ethnicityTextChoices = [caucasionChoice, blackChoice, filipinoChoice, chineseChoice, nativeAmericanChoice, hispanicChoice, southAsianChoice, japaneseChoice, middleEasternChoice, southeastAsianChoice, unknownChoice]
    let ethnicityFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: ethnicityTextChoices)
    let ethnicityStep = ORKQuestionStep(identifier: "ethnicity", title: "To which ethnic or cultural group did your parents belong? (Check all that apply)", answer: ethnicityFormat)
    steps += [ethnicityStep]
    
    // Marital Status
    let marriedChoice = ORKTextChoice(text: "Married or Common Law", value: MaritalStatus.married.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let singleChoice = ORKTextChoice(text: "Single (never married)", value: MaritalStatus.single.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let divorcedChoice = ORKTextChoice(text: "Divorced or Separated", value: MaritalStatus.divorced.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let widowedChoice = ORKTextChoice(text: "Widowed", value: MaritalStatus.widowed.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let maritalTextChoices = [marriedChoice, singleChoice, divorcedChoice, widowedChoice]
    let maritalStatusFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: maritalTextChoices)
    let maritalStatusStep = ORKQuestionStep(identifier: "maritalStatus", title: "What is your marital status?", answer: maritalStatusFormat)
    steps += [maritalStatusStep]
    
    // How many children?
    let numChildrenFormat = ORKNumericAnswerFormat(style: .integer, unit: "children", minimum: 0, maximum: nil)
    let numChildrenStep = ORKQuestionStep(identifier: "numChildren", title: "How many children do you have?", answer: numChildrenFormat)
    steps += [numChildrenStep]
    
    // TODO: if > 1 ask for approximate age separation, ask for oldest/yougest age
    
    // Education
    let lessHighSchoolChoice = ORKTextChoice(text: "Less than high school", value: Education.lessThanHighSchool.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let someHighSchoolChoice = ORKTextChoice(text: "Some high school", value: Education.someHighSchool.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let completedHighSchoolChoice = ORKTextChoice(text: "Completed high school", value: Education.completedHighSchool.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let someCollegeChoice = ORKTextChoice(text: "Some college", value: Education.someCollege.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let completedCollege = ORKTextChoice(text: "Completed college", value: Education.completedCollege.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let someUniversityChoice = ORKTextChoice(text: "Some university", value: Education.someUniversity.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let completedUniversity = ORKTextChoice(text: "Completed university", value: Education.completedUniversity.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let mastersChoice = ORKTextChoice(text: "Masters degree", value: Education.masters.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let phdChoice = ORKTextChoice(text: "PhD", value: Education.phd.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let educationChoices = [lessHighSchoolChoice, someHighSchoolChoice, completedHighSchoolChoice, someCollegeChoice, completedCollege, someUniversityChoice, completedUniversity, mastersChoice, phdChoice]
    let educationFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: educationChoices)
    let educationStep = ORKQuestionStep(identifier: "education", title: "What is the highest education you have achieved?", answer: educationFormat)
    steps += [educationStep]
    
    // Employed
    let employedStep = ORKQuestionStep(identifier: "employed", title: "Are you currently employed?", answer: ORKBooleanAnswerFormat())
    steps += [employedStep]
    
    // TODO: if yes, ask occupation
    
    // TODO: Income Step
    
    // Community Standing
    let communityFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: true)
    let communityStandingStep = ORKQuestionStep(identifier: "communityStanding", title: "Think of a ladder as representing where people stand in their communities.", text: "People define community in different ways; please define it in whatever way is most meaningful to you. At the top of the ladder are people who have the highest standing in their community. At the bottom are the people who have the lowest standing in their community.\n\nWhere would you place yourself on a ladder?", answer: communityFormat)
    steps += [communityStandingStep]
    
    // Break
    let breakStep = ORKInstructionStep(identifier: "break")
    breakStep.text = "Now we are going to ask you questions about your current home address and why you chose to live in this location. Your residential location is one of the primary drivers of your built environment exposures."
    steps += [breakStep]
    
    // Current Address
    let currentAddressStep = ORKQuestionStep(identifier: "currentAddress", title: "What is your current address?", answer: ORKLocationAnswerFormat())
    steps += [currentAddressStep]
    
    // Number of years in current house
    let numYearsFormat = ORKNumericAnswerFormat(style: .decimal, unit: "years", minimum: 0, maximum: nil)
    let numYearsStep = ORKQuestionStep(identifier: "numberOfYearsAtCurrentAddress", title: "How many years have you been living at this address?", answer: numYearsFormat)
    steps += [numYearsStep]
    
    // Own or Rent
    let ownChoice = ORKTextChoice(text: "Own", value: HomeOwnership.own.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let rentChoice = ORKTextChoice(text: "Rent", value: HomeOwnership.rent.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let ownershipChoices = [ownChoice, rentChoice]
    let ownershipFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: ownershipChoices)
    let ownershipStep = ORKQuestionStep(identifier: "ownership", title: "Do you own or rent your home?", answer: ownershipFormat)
    steps += [ownershipStep]
    
    // Home Description
    let detachedChoice = ORKTextChoice(text: "Detached Home", value: HomeDescription.detached.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let duplexChoice = ORKTextChoice(text: "Duplex", value: HomeDescription.duplex.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let apartmentChoice = ORKTextChoice(text: "Building with 3 or more apartments", value: HomeDescription.apartment.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let mobileChoice = ORKTextChoice(text: "Mobile home", value: HomeDescription.mobileHome.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let otherChoice = ORKTextChoice(text: "Other", value: HomeDescription.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let homeDescriptionChoices = [detachedChoice, duplexChoice, apartmentChoice, mobileChoice, otherChoice]
    let homeDescriptionFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: homeDescriptionChoices)
    let homeDescriptionStep = ORKQuestionStep(identifier: "homeDescription", title: "Which best describes your home?", answer: homeDescriptionFormat)
    steps += [homeDescriptionStep]
    
    // Number of people in the house
    let numPeopleFormat = ORKNumericAnswerFormat(style: .integer, unit: "people", minimum: 0, maximum: nil)
    let numPeopleStep = ORKQuestionStep(identifier: "numPeople", title: "How many people are living in your household?", answer: numPeopleFormat)
    steps += [numPeopleStep]
    
    // Number of vehicles
    let numVehiclesFormat = ORKNumericAnswerFormat(style: .integer, unit: "vehicles", minimum: 0, maximum: nil)
    let numVehiclesStep = ORKQuestionStep(identifier: "numVehicles", title: "How many vehicles are associated with your household?", answer: numVehiclesFormat)
    steps += [numVehiclesStep]
    
    // Influence
    
    
    let environmentalExposureFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Highest Quality", minimumValueDescription: "Lowest Quality")
    let environmentalExposureStep = ORKQuestionStep(identifier: "environmentalExposure", title: "In terms of environmental exposures (e.g. air pollution, noise, green spaces) how would you rank your current location?", answer: environmentalExposureFormat)
    steps += [environmentalExposureStep]
    
    // Commute?
    let commuteBool = ORKQuestionStep(identifier: "commuteBool", title: "Do you commute to work?", answer: ORKBooleanAnswerFormat())
    steps += [commuteBool]
    
    // TODO: make dynamic
//    let predicate = NSPredicate(format: "identifier = commuteBool")
//    let predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [predicate], destinationStepIdentifiers: [""], defaultStepIdentifier: nil, validateArrays: false)
    
    
    return ORKNavigableOrderedTask(identifier: "baselineSurvey", steps: steps)
}
