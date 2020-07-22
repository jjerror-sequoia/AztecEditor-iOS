//
//  BackgroundColorFormatter.swift
//  
//
//  Created by Kenson Yee on 7/22/20.
//

import UIKit

import UIKit

class BackgroundColorFormatter: StandardAttributeFormatter {

    init(color: UIColor = .clear) {
        super.init(attributeKey: .backgroundColor,
                   attributeValue: color,
                   htmlRepresentationKey: .backgroundColorHtmlRepresentation)
    }
}
