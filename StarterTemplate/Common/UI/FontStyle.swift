//
//  FontStyle.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 17/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

public enum FontStyle {
    case largeTitle, title1, title2, title3, headline, body, callout, subhead, subheadBold, footnote, captionBold, caption1, caption2, footnoteBold
    
    var font: String {
        switch self {
        case .largeTitle, .title1, .title2, .title3, .headline, .subheadBold, .captionBold, .footnoteBold:
            return "ArialRoundedMTBold"
        case .body, .callout, .subhead, .footnote, .caption1, .caption2:
            return "AppleSDGothicNeo-Regular"
        }
    }
    
    var size: Float {
        switch self {
        case .largeTitle:
            return 34
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .body:
            return 17
        case .callout:
            return 16
        case .subhead:
            return 16
        case .subheadBold:
            return 16
        case .footnoteBold:
            return 13
        case .footnote:
            return 13
        case .captionBold:
            return 12
        case .caption1:
            return 12
        case .caption2:
            return 11
        }
    }
}
