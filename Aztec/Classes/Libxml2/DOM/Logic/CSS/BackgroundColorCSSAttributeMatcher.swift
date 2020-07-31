//
//  BackgroundColorCSSAttributeMatcher.swift
//  Aztec
//
//  Created by Kenson Yee on 7/30/20.
//  Copyright © 2020 Automattic Inc. All rights reserved.
//

import Foundation

open class BackgroundColorCSSAttributeMatcher: CSSAttributeMatcher {
    
    public func check(_ cssAttribute: CSSAttribute) -> Bool {
        guard let value = cssAttribute.value else {
            return false
        }
        
        return cssAttribute.type == .backgroundColor && !value.isEmpty
    }
}
