//
//  ConsentTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/20/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    // Visual Consent Step
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    // Consent Sharing Step
    let all = ORKTextChoice(text: "Share my data with Oregon State University and qualified researchers worldwide", value: "all" as NSCoding & NSCopying & NSObjectProtocol)
    let onlyOSU = ORKTextChoice(text: "Only share my data with Oregon State University", value: "onlyOSU" as NSCoding & NSCopying & NSObjectProtocol)
    let onlyOnDevice = ORKTextChoice(text: "Do not share my data with anyone, keep my data on my device", value: "onlyOnDevice" as NSCoding & NSCopying & NSObjectProtocol)
    let answers = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: [all, onlyOSU, onlyOnDevice])
    let sharingStep = ORKConsentSharingStep(identifier: "sharingStep", title: "Who would you like to share your information with?", answer: answers)
    sharingStep.isOptional = false
    steps += [sharingStep]
    
    // Consent Review Step
    let signature = (consentDocument.signatures?.first)! as ORKConsentSignature
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    reviewConsentStep.reasonForConsent = reasonForConsent
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
