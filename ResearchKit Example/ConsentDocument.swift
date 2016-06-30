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
    consentDocument.title = "ResearchKit Example"
    
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
            consentSection.summary = "Lorem ipsum dolor sit amet"
            consentSection.content = "Etiam iaculis dui id urna posuere gravida. Suspendisse dictum erat ut metus mollis, et bibendum felis facilisis. Etiam volutpat vitae lorem non volutpat. Etiam pulvinar porta vulputate. Vivamus ornare commodo finibus. Integer convallis mauris sit amet tortor vestibulum dapibus nec id tellus. Aliquam non tellus aliquet, venenatis mi sed, commodo ipsum. Sed dapibus ligula vulputate metus sodales, quis consequat justo suscipit. Morbi malesuada porttitor metus a venenatis. In hac habitasse platea dictumst. Sed id vehicula lacus. In convallis ante ipsum, nec congue tellus fermentum quis. Phasellus in lorem nec magna viverra consectetur eu et quam. Sed sed purus eget turpis suscipit tincidunt. Mauris volutpat gravida faucibus."
            break
        case .dataGathering:
            consentSection.summary = "Mauris volutpat gravida faucibus"
            consentSection.content = "Suspendisse laoreet feugiat velit sit amet tempor. Aenean orci risus, lacinia sit amet porttitor imperdiet, faucibus a risus. Aenean vitae risus vehicula, eleifend ligula vitae, tincidunt est. Curabitur vehicula malesuada dictum. Nullam cursus fermentum odio, id gravida est fringilla ac. Praesent laoreet mauris in ipsum blandit vulputate. Morbi non enim eleifend, laoreet nulla eu, euismod augue. Pellentesque efficitur vehicula mauris sit amet venenatis. Nullam volutpat ultricies aliquet. Mauris non metus velit. Sed efficitur tristique scelerisque."
            break
        case .privacy:
            consentSection.summary = "Sed efficitur tristique scelerisque"
            consentSection.content = "Integer egestas, enim nec sagittis hendrerit, velit justo luctus dolor, congue placerat mauris turpis sed odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus consectetur ante vitae pretium commodo. Ut a placerat felis. Proin a condimentum lacus, eu varius mi. Etiam id arcu laoreet, viverra est eget, rhoncus diam. Praesent viverra sed nunc sed tristique. Nunc tincidunt tellus et eros elementum, vitae lobortis justo porttitor. Aliquam erat volutpat. Quisque vitae leo augue. Morbi consequat turpis orci, quis pharetra arcu pharetra sed. Integer iaculis luctus molestie. Nam scelerisque cursus enim, eu pellentesque enim dapibus at. Pellentesque quis lacus eget erat pellentesque dictum. Proin quam orci, accumsan eu tellus id, ullamcorper imperdiet urna."
            break
        case .dataUse:
            consentSection.summary = "Proin quam orci, accumsan eu tellus id, ullamcorper imperdiet urna"
            consentSection.content = "Etiam sed nulla risus. Quisque sit amet purus mollis libero posuere vulputate. Sed vel suscipit odio. Sed eget tristique enim. Sed vitae vehicula eros, id consequat mauris. Etiam fringilla faucibus nunc, sed varius libero maximus in. Phasellus eu nisl sit amet tellus auctor mattis. Vivamus eleifend sed enim a egestas. Nulla gravida egestas tellus, ac auctor nulla facilisis at. Nunc vitae lorem vitae erat faucibus elementum vitae vel tortor. Fusce eu felis et nunc elementum accumsan in et libero. Aliquam porta erat vel nisi consequat, a lacinia est tincidunt. Sed non lacus ac velit tincidunt dignissim sit amet at ligula. Duis nunc ante, mattis sed pulvinar elementum, fringilla vel ante. Proin consectetur enim quis tellus congue, quis semper nunc gravida. Suspendisse vehicula sem nec elit fringilla fermentum."
            break
        case .timeCommitment:
            consentSection.summary = "Suspendisse vehicula sem nec elit fringilla fermentum"
            consentSection.content = "Morbi pharetra ligula arcu, ornare rutrum lectus luctus et. Nunc nec nisl ipsum. Morbi et risus ac magna porttitor convallis. In ut velit arcu. Nunc accumsan, est non fermentum feugiat, sapien odio hendrerit leo, sed vehicula nunc ipsum eu velit. Donec vitae neque eu quam mattis pretium. Ut quis cursus elit, ut scelerisque purus. Aliquam fermentum massa justo, sit amet ultricies mauris imperdiet in. Phasellus tempus dapibus lorem, cursus luctus nisi tincidunt sed. Donec laoreet orci massa, non rhoncus justo faucibus vitae. Maecenas vitae magna quis elit vulputate bibendum vitae sit amet ex. Etiam turpis dui, finibus ac eros at, malesuada lacinia libero. Integer non ipsum in elit rhoncus dignissim nec sit amet est. Nulla aliquet purus sapien, ut venenatis enim mollis nec."
            break
        case .studyTasks:
            consentSection.summary = "Nulla aliquet purus sapien, ut venenatis enim mollis nec"
            consentSection.content = "Morbi gravida sapien id cursus consectetur. Duis sit amet pharetra lacus. In cursus libero massa, ut lacinia est auctor in. Pellentesque eros arcu, iaculis et sollicitudin id, posuere sit amet felis. Nunc pretium orci at risus tincidunt tincidunt. Mauris iaculis enim sed ligula pulvinar ullamcorper. Mauris euismod ligula vel ipsum bibendum, at venenatis magna semper. Aliquam erat volutpat. Cras elementum enim et dui finibus, eget sollicitudin nibh hendrerit. Aliquam malesuada tellus in risus dignissim, eget feugiat felis fermentum. Morbi ultrices eros ac sapien ultrices, quis mollis nisi viverra. Morbi augue felis, volutpat at elementum non, porta id neque."
            break
        case .studySurvey:
            consentSection.summary = "Morbi augue felis, volutpat at elementum non, porta id neque"
            consentSection.content = "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer posuere lorem sed felis tristique cursus. Vestibulum diam ante, venenatis et tortor vitae, elementum bibendum lacus. Etiam nec cursus urna, ac congue est. Nulla ultrices erat eu arcu egestas faucibus. Nunc tristique sed ligula sed lobortis. Quisque faucibus, mi nec blandit blandit, dolor nisi pharetra justo, ac pharetra dui arcu sed massa. Vivamus semper, elit in bibendum iaculis, ex mauris gravida dolor, ac dignissim orci urna ac tellus. Integer non mauris et nisl blandit tincidunt at eu massa. Praesent ornare arcu sed eros faucibus ultricies. Nulla in luctus nunc. Phasellus eget porta metus, eget eleifend mi. Ut egestas imperdiet tempor."
            break
        case .withdrawing:
            consentSection.summary = "Ut egestas imperdiet tempor"
            consentSection.content = "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse non arcu ante. Pellentesque diam mi, dictum vel lorem nec, condimentum elementum lacus. Etiam tortor nisl, posuere at elementum vitae, elementum vitae velit. In ornare eros justo, at ultrices massa semper id. Donec sit amet magna diam. Proin tincidunt ut libero eu malesuada. Suspendisse a efficitur elit, at volutpat ligula. Cras nibh felis, aliquet in pharetra non, cursus eget eros. Aliquam nec semper augue, vitae egestas felis. Suspendisse at diam a nibh tempus vestibulum sed eu nulla. In quis condimentum tortor, tincidunt elementum nisl."
            break
        default:
            consentSection.summary = "In quis condimentum tortor, tincidunt elementum nisl"
            consentSection.content = "Proin eu congue mauris, nec interdum dolor. Nullam vehicula, ante a ornare ullamcorper, nulla ipsum malesuada lorem, nec dictum urna leo vitae quam. Proin efficitur viverra velit, id congue justo euismod quis. Nulla faucibus, nibh ut pretium posuere, nisl felis auctor leo, quis feugiat lacus justo in turpis. Praesent quis dolor vestibulum ante pellentesque blandit non vehicula neque. Mauris efficitur, leo eget vulputate elementum, justo lacus fringilla est, feugiat eleifend urna enim eu magna. Duis ac sollicitudin ex. Quisque pharetra nibh at massa porta porta. Nunc posuere erat at tellus pretium, eu molestie enim elementum. Aliquam sollicitudin sapien ac dapibus congue. Integer feugiat, neque vel malesuada tincidunt, nulla magna mattis nibh, eu fermentum leo turpis eget justo. Suspendisse nunc elit, pretium id eros id, rutrum dictum lorem. Vestibulum eget finibus mauris. Duis posuere gravida libero sit amet finibus. Proin eget nibh id ipsum ullamcorper ultrices."
            break
        }
        
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "participant"))
    
    return consentDocument
}
