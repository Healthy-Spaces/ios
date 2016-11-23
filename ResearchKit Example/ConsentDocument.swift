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
        .withdrawing
    ]
    
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
        default:
            consentSection.summary = defaultSummary
            consentSection.content = defaultContent
            break
        }
        
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "participant"))
    
    let titles = ["Welcome", "Data Gathering", "Privacy", "Data Use", "Time Commitment", "Study Tasks", "Study Survey", "Withdrawing", "Questions + Contact Info"]
    let summaries = [overviewSummary, dataGatheringSummary, privacySummary, dataUseSummary, timeCommitmentSummary, studyTasksSummary, studySurveySummary, withdrawingSummary, questionsSummay]
    let contents = [overviewContent, dataGatheringContent, privacyContent, dataUseContent, timeCommitmentContent, studyTasksContent, studySurveyContent, withdrawingContent, questionsContent]
    var reviewString = "<html><head><title>Healthy Places</title></head><body>"
    for (i, _) in titles.enumerated() { // (i, _) because only using i
        reviewString += ("<h3>" + titles[i]    + "</h3>")
        reviewString += ("<p>"  + summaries[i] + "</p>")
        //reviewString += ("<br>")
        reviewString += ("<p>"  + contents[i]  + "</p>")
    }
    reviewString += "</body></html>"
    
    consentDocument.htmlReviewContent = reviewString
    
    return consentDocument
}
