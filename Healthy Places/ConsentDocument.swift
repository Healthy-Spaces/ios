//
//  InformedConsent.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/20/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = consentDocumentTitle
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing,
        .custom,
        .custom,
        .custom
    ]
    
    var customCounter = 0
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { consentSectionType in
        let consentSection = ORKConsentSection(type: consentSectionType)
        
        switch consentSectionType {
        case .overview:
            consentSection.summary = overviewSummary
            consentSection.content = overviewContent
            break
        case .dataGathering:
            consentSection.summary = dataGatheringSummary
            consentSection.content = dataGatheringContent
            break
        case .privacy:
            consentSection.summary = privacySummary
            consentSection.content = privacyContent
            break
        case .dataUse:
            consentSection.summary = dataUseSummary
            consentSection.content = dataUseContent
            break
        case .timeCommitment:
            consentSection.summary = timeCommitmentSummary
            consentSection.content = timeCommitmentContent
            break
        case .studyTasks:
            consentSection.summary = studyTasksSummary
            consentSection.content = studyTasksContent
            break
        case .studySurvey:
            consentSection.summary = studySurveySummary
            consentSection.content = studySurveyContent
            break
        case .withdrawing:
            consentSection.summary = withdrawingSummary
            consentSection.content = withdrawingContent
            break
        case .custom:
            switch customCounter {
            case 0: // Potential Benefits
                consentSection.title = benefitsTitle
                consentSection.summary = benefitsSummary
                consentSection.content = benefitsContent
                break
            case 1: // Potential Harm
                consentSection.title = harmTitle
                consentSection.summary = harmSummary
                consentSection.content = harmContent
                break
            case 2: // Questions & Contact Information
                consentSection.title = questionsTitle
                consentSection.summary = questionsSummary
                consentSection.content = questionsContent
                break
            default: break
            }
            customCounter += 1
            break
        default:
            consentSection.summary = defaultSummary
            consentSection.content = defaultContent
            break
        }
        
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "participant"))
    
    let titles = ["Welcome", "Data Gathering", "Privacy", "Data Use", "Time Commitment", "Study Tasks", "Study Survey", "Withdrawing", "Potential Benefits", "Potential Harm", "Questions &amp; Contact Info"]
    let summaries = [overviewSummary, dataGatheringSummary, privacySummary, dataUseSummary, timeCommitmentSummary, studySurveySummary, studyTasksSummary, withdrawingSummary, benefitsSummary, harmSummary, questionsSummary]
    let contents = [overviewContent, dataGatheringContent, privacyContent, dataUseContent, timeCommitmentContent, studySurveyContent, studyTasksContent, withdrawingContent, benefitsContent, harmContent, questionsContent]
    var reviewString = "<html><head><title>Healthy Places</title></head><body><div class='content'>"
    for (i, _) in titles.enumerated() { // (i, _) because only using i
        reviewString += ("<h3>" + titles[i]    + "</h3>")
        reviewString += ("<p>"  + summaries[i] + "</p>")
        //reviewString += ("<br>")
        reviewString += ("<p>"  + contents[i]  + "</p>")
    }
    reviewString += "</div></body></html>"
    
    consentDocument.htmlReviewContent = reviewString
    
    return consentDocument
}
