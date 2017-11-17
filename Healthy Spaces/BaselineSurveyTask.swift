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
    instructionStep.text = "We begin with asking you some basic questions to help us better understand who you are and how different characteristics may influence your environmental exposures."
    steps += [instructionStep]
    
    // Sex
    let maleChoice = ORKTextChoice(text: "Male", value: Sex.male.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let femaleChoice = ORKTextChoice(text: "Female", value: Sex.female.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let otherChoice = ORKTextChoice(text: "Other", value: Sex.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let sexChoices = [maleChoice, femaleChoice, otherChoice]
    let sexFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: sexChoices)
    let sexStep = ORKQuestionStep(identifier: "sex", title: "Sex", answer: sexFormat)
    steps += [sexStep]
    
    // Age
    let ageFormat = ORKNumericAnswerFormat(style: .integer, unit: "Years", minimum: 0, maximum: nil)
    let ageStep = ORKQuestionStep(identifier: "age", title: "Age", answer: ageFormat)
    steps += [ageStep]
    
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
    let neverHadChildrenChoice = ORKTextChoice(text: "Do not have children", value: Children.neverHadChildren.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let oneChildChoice = ORKTextChoice(text: "One", value: Children.one.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let twoChildrenChoice = ORKTextChoice(text: "Two", value: Children.two.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let threeChildrenChoice = ORKTextChoice(text: "Three", value: Children.three.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let fourOrMoreChildrenChoice = ORKTextChoice(text: "Four or more", value: Children.fourOrMore.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let noChildrenChoice = ORKTextChoice(text: "Children no longer living at home", value: Children.noChildren.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let childrenChoices = [neverHadChildrenChoice, oneChildChoice, twoChildrenChoice, threeChildrenChoice, fourOrMoreChildrenChoice, noChildrenChoice]
    let numChildrenFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: childrenChoices)
    let numChildrenStep = ORKQuestionStep(identifier: "numChildren", title: "How many children do you have living at home?", answer: numChildrenFormat)
    steps += [numChildrenStep]
    
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
    
    // Describe Occupation
    let occupationDescriptionStep = ORKQuestionStep(identifier: "occupationDescription", title: "Please describe your occupation (if you do not work skip question)?", answer: ORKTextAnswerFormat())
    steps += [occupationDescriptionStep]
    
    // Income
    let zeroIncomeChoice = ORKTextChoice(text: "$0 - $9,999", value: Income.zero.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let tenThousandIncomeChoice = ORKTextChoice(text: "$10,000 - $19,999", value: Income.tenThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let twentyThousandIncomeChoice = ORKTextChoice(text: "$20,000 - $29,999", value: Income.twentyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let thirtyThousandIncomeChoice = ORKTextChoice(text: "$30,000 - $39,999", value: Income.thirtyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let fourtyThousandIncomeChoice = ORKTextChoice(text: "$40,000 - $49,999", value: Income.fourtyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let fiftyThousandIncomeChoice = ORKTextChoice(text: "$50,000 - $59,999", value: Income.fiftyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let sixtyThousandIncomeChoice = ORKTextChoice(text: "$60,000 - $79,999", value: Income.sixtyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let eightyThousandIncomeChoice = ORKTextChoice(text: "$80,000 - $99,999", value: Income.eightyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let oneHundredThousandIncomeChoice = ORKTextChoice(text: "$100,000 - $149,999", value: Income.oneHundredThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let oneHundredFiftyThousandIncomeChoice = ORKTextChoice(text: "$150,000 or over", value: Income.oneHundredFiftyThousand.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let preferNotToSayIncomeChoice = ORKTextChoice(text: "Prefer not to say", value: Income.preferNotToSay.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let incomeChoices = [zeroIncomeChoice, tenThousandIncomeChoice, twentyThousandIncomeChoice, thirtyThousandIncomeChoice, fourtyThousandIncomeChoice, fiftyThousandIncomeChoice, sixtyThousandIncomeChoice, eightyThousandIncomeChoice, oneHundredThousandIncomeChoice, oneHundredFiftyThousandIncomeChoice, preferNotToSayIncomeChoice]
    let incomeFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: incomeChoices)
    let incomeStep = ORKQuestionStep(identifier: "income", title: "What is the best estimate of the total income, before taxes and deductions, of all household members, from all sources for last years tax period.", answer: incomeFormat)
    steps += [incomeStep]
    
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
    
    // Social Standing
    let communityFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: true)
    let communityStandingStep = ORKQuestionStep(identifier: "communityStanding", title: "People define social standing in different ways; please define it in whatever way is most meaningful to you.  At the top of the scale below (10) are people who have the highest standing in their community.  At the bottom (1) are people who have the lowest standing in their community.  Where would you place yourself on this scale?", answer: communityFormat)
    steps += [communityStandingStep]
    
    // Break
    let breakStep = ORKInstructionStep(identifier: "break")
    breakStep.text = "Now we are going to ask you questions about your current home address and why you chose to live in this location. Your residential location is one of the primary drivers of your built environment exposures."
    steps += [breakStep]
    
    // Current Address
    let currentAddressStep = ORKQuestionStep(identifier: "currentAddress", title: "What is your current address?", answer: ORKLocationAnswerFormat())
    steps += [currentAddressStep]
    
    // Number of years in current house
    let numYearsFormat = ORKNumericAnswerFormat(style: .integer, unit: "years", minimum: 0, maximum: nil)
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
    let otherHomeChoice = ORKTextChoice(text: "Other", value: HomeDescription.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let homeDescriptionChoices = [detachedChoice, duplexChoice, apartmentChoice, mobileChoice, otherHomeChoice]
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
    let housingPriceChoice = ORKTextChoice(text: "Housing or rental price", value: HomeInfluence.housingPrice.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingWorkplaceChoice = ORKTextChoice(text: "Closer to a workplace", value: HomeInfluence.closeToWorkplace.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingSchoolDistrictChoice = ORKTextChoice(text: "In a desirable school district", value: HomeInfluence.schoolDistrict.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingEntertainmentChoice = ORKTextChoice(text: "Closer to shopping, entertainment, restaurants", value: HomeInfluence.closeToEntertainment.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingCivicChoice = ORKTextChoice(text: "Closer to social, religious, civic, cultural, or recreational facilities", value: HomeInfluence.closeToCivic.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingTransportationChoice = ORKTextChoice(text: "Close to public transportation", value: HomeInfluence.closeToTransportation.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingFriendsChoice = ORKTextChoice(text: "Close to friends or relatives", value: HomeInfluence.closeToFriends.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingNeighborhoodChoice = ORKTextChoice(text: "Desirable neighborhood", value: HomeInfluence.desirableNeighborhood.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingCharacterisitcsChoice = ORKTextChoice(text: "Characteristics of this house or property", value: HomeInfluence.characteristicsOfHouse.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let housingOtherChoice = ORKTextChoice(text: "Other", value: HomeInfluence.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let influenceChoices = [housingPriceChoice, housingWorkplaceChoice, housingSchoolDistrictChoice, housingEntertainmentChoice, housingCivicChoice, housingTransportationChoice, housingFriendsChoice, housingNeighborhoodChoice, housingCharacterisitcsChoice, housingOtherChoice]
    let influenceFormat = ORKTextChoiceAnswerFormat(style: .multipleChoice, textChoices: influenceChoices)
    let influenceStep = ORKQuestionStep(identifier: "influence", title: "What influenced your decision to move to this location?", text: "Select the top 5", answer: influenceFormat)
    steps += [influenceStep]
    
    // What is it like?
    let neighborhoodExperienceFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Very Good", minimumValueDescription: "Very Bad")
    let neighborhoodExperienceStep = ORKQuestionStep(identifier: "neighborhoodExperience", title: "What is it like living in your neighborhood?", answer: neighborhoodExperienceFormat)
    steps += [neighborhoodExperienceStep]
    
    // Exposure
    let environmentalExposureFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: 1, step: 1, vertical: false, maximumValueDescription: "Highest Quality", minimumValueDescription: "Lowest Quality")
    let environmentalExposureStep = ORKQuestionStep(identifier: "environmentalExposure", title: "In terms of environmental exposures (e.g. air pollution, noise, green spaces) how would you rank your current location?", answer: environmentalExposureFormat)
    steps += [environmentalExposureStep]
    
    // Commute Length
    let commuteLengthFormat = ORKNumericAnswerFormat(style: .integer, unit: "minutes", minimum: 0, maximum: nil)
    let commuteLengthStep = ORKQuestionStep(identifier: "commuteLength", title: "How long (in minutes) is your commute to work (one way)?", text: "Enter 0 if you do not commute", answer: commuteLengthFormat)
    steps += [commuteLengthStep]
    
    // Commute Method
    let commuteMethodNoneChoice = ORKTextChoice(text: "Do not commute", value: Commute.noCommute.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodBikeChoice = ORKTextChoice(text: "Bike", value: Commute.bike.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodWalkChoice = ORKTextChoice(text: "Walk", value: Commute.walk.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodDriverChoice = ORKTextChoice(text: "Vehicle (driver)", value: Commute.driver.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodPassengerChoice = ORKTextChoice(text: "Vehicle (passenger)", value: Commute.passenger.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodPublicTransitChoice = ORKTextChoice(text: "Public transit", value: Commute.publicTransit.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodTaxiChoice = ORKTextChoice(text: "Taxi", value: Commute.taxi.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodOtherChoice = ORKTextChoice(text: "Other", value: Commute.other.rawValue as NSCoding & NSCopying & NSObjectProtocol)
    let commuteMethodChoices = [commuteMethodNoneChoice, commuteMethodBikeChoice, commuteMethodWalkChoice, commuteMethodDriverChoice, commuteMethodPassengerChoice, commuteMethodPublicTransitChoice, commuteMethodTaxiChoice, commuteMethodOtherChoice]
    let commuteMethodFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: commuteMethodChoices)
    let commuteMethodStep = ORKQuestionStep(identifier: "commuteMethod", title: "How do you normally commute to work?", answer: commuteMethodFormat)
    steps += [commuteMethodStep]
    
    // Break
    let breakStep2 = ORKInstructionStep(identifier: "break2")
    breakStep2.text = "Now we are going to ask you where you lived in your 2 previous homes. This information will be used to assess how your built environment exposures have changed over time."
    steps += [breakStep2]
    
    // Previous Home Address 1
    let previousHomeAddressStep1 = ORKQuestionStep(identifier: "previousHomeAddress1", title: "What was your previous home address?", answer: ORKLocationAnswerFormat())
    steps += [previousHomeAddressStep1]
    
    // Into/Out of Home Date Format:
    let dateIntoOutOfHomeFormat = ORKDateAnswerFormat(style: .date, defaultDate: Date(), minimumDate: nil, maximumDate: nil, calendar: nil)
    
    // Date into home 1
    let dateIntoHomeStep1 = ORKQuestionStep(identifier: "dateIntoHome1", title: "Date moved into this home:", answer: dateIntoOutOfHomeFormat)
    steps += [dateIntoHomeStep1]
    
    // Date out of home 1
    let dateOutOfHomeStep1 = ORKQuestionStep(identifier: "dateOutOfHome1", title: "Date moved out of this home:", answer: dateIntoOutOfHomeFormat)
    steps += [dateOutOfHomeStep1]
    
    // Previous Home Address 2
    let previousHomeAddressStep2 = ORKQuestionStep(identifier: "previousHomeAddress2", title: "What was your previous home address?", answer: ORKLocationAnswerFormat())
    steps += [previousHomeAddressStep2]
    
    // Date into home 2
    let dateIntoHomeStep2 = ORKQuestionStep(identifier: "dateIntoHome2", title: "Date moved into this home:", answer: dateIntoOutOfHomeFormat)
    steps += [dateIntoHomeStep2]
    
    // Date out of home 2
    let dateOutOfHomeStep2 = ORKQuestionStep(identifier: "dateOutOfHome2", title: "Date moved out of this home:", answer: dateIntoOutOfHomeFormat)
    steps += [dateOutOfHomeStep2]
    
    
    return ORKNavigableOrderedTask(identifier: "baselineSurvey", steps: steps)
}
