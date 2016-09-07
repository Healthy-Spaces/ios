//
//  RegistrationTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 8/29/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var RegistrationTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    // Eligibility Step
    
    
    // Registration Step
    let registrationStep = ORKRegistrationStep(identifier: "registrationStep", title: "Account Registration", text: "Please register to join the study", options: [.includeGivenName, .includeFamilyName, .includeDOB, .includeGender])
    steps += [registrationStep]
    
    
    // Consent Step
    // Visual Consent Step
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    // Consent Sharing Step
    let all = ORKTextChoice(text: "Share my data with Oregon State University and qualified researchers worldwide", value: "all")
    let onlyOSU = ORKTextChoice(text: "Only share my data with Oregon State University", value: "onlyOSU")
    let onlyOnDevice = ORKTextChoice(text: "Do not share my data with anyone, keep my data on my device", value: "onlyOnDevice")
    let answers = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: [all, onlyOSU, onlyOnDevice])
    let sharingStep = ORKConsentSharingStep(identifier: "sharingStep", title: "Who would you like to share your information with?", answer: answers)
    sharingStep.isOptional = false
    steps += [sharingStep]
    
    // Consent Review Step
    let signature = (consentDocument.signatures?.first)! as ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    reviewConsentStep.reasonForConsent = reasonForConsent
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "registrationTask", steps: steps)
}

var readDataTypes: Set<HKQuantityType> {
    let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)
    let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
    let distanceCycling = HKObjectType.quantityType(forIdentifier: .distanceCycling)
    
    return Set(arrayLiteral: stepCount!, distanceWalkingRunning!, distanceCycling!)
}
