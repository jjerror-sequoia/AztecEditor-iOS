//
//  BackgroundColorElementAttributeConverter.swift
//  Aztec
//
//  Created by Kenson Yee on 7/30/20.
//  Copyright © 2020 Automattic Inc. All rights reserved.
//

import Foundation
import UIKit

class BackgroundColorElementAttributesConverter: ElementAttributeConverter {

    let cssAttributeMatcher = BackgroundColorCSSAttributeMatcher()
    
    func convert(
        _ attribute: Attribute,
        inheriting attributes: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
        
        guard let cssColor = attribute.firstCSSAttribute(ofType: .backgroundColor),
            let colorValue = cssColor.value,
            let color = ColorProvider.shared.color(named: colorValue) ?? UIColor(hexString: colorValue) else {
            return attributes
        }
        
        var attributes = attributes
        
        attributes[.backgroundColor] = color
        
        return attributes
    }
}
