//
//  SharingOptionsTask.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/6/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import ResearchKit

public var SharingOptionsStep: ORKStep {
    
    let all = ORKTextChoice(text: "Share my data with Oregon State University and qualified researchers worldwide", value: "all" as NSCoding & NSCopying & NSObjectProtocol)
    let onlyOSU = ORKTextChoice(text: "Only share my data with Oregon State University", value: "onlyOSU" as NSCoding & NSCopying & NSObjectProtocol)
    let onlyOnDevice = ORKTextChoice(text: "Do not share my data with anyone, keep my data on my device", value: "onlyOnDevice" as NSCoding & NSCopying & NSObjectProtocol)
    let answers = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: [all, onlyOSU, onlyOnDevice])
    let sharingOptionsStep = ORKQuestionStep(identifier: "sharingOptions", title: "Sharing Options", text: "Oregon State University will receive your study data from your participation in this study.\n \n Sharing your coded study data more broadly (without information such as your name) may benefit this and future research", answer: answers)
    sharingOptionsStep.isOptional = false
    
    return sharingOptionsStep
}
