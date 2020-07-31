//
//  EmStringAttributeConverter.swift
//  Aztec
//
//  Created by Kenson Yee on 7/30/20.
//  Copyright © 2020 Automattic Inc. All rights reserved.
//

import Foundation
import UIKit


/// Converts the bg color style information from string attributes and aggregates it into an
/// existing array of element nodes.
///
open class EmStringAttributeConverter: StringAttributeConverter {
    
    private let toggler = HTMLStyleToggler(defaultElement: .em, cssAttributeMatcher: BackgroundColorCSSAttributeMatcher())
    
    public func convert(
        attributes: [NSAttributedString.Key: Any],
        andAggregateWith elementNodes: [ElementNode]) -> [ElementNode] {
        
        var elementNodes = elementNodes
        
        // We add the representation right away, if it exists... as it could contain attributes beyond just this
        // style.  The enable and disable methods below can modify this as necessary.
        //
        if let representation = attributes[NSAttributedString.Key.emHtmlRepresentation] as? HTMLRepresentation,
            case let .element(representationElement) = representation.kind {
            
            elementNodes.append(representationElement.toElementNode())
        }
        
        if shouldEnableBGColor(for: attributes) {
            return toggler.enable(in: elementNodes)
        } else {
            return toggler.disable(in: elementNodes)
        }
    }

    // MARK: - Style Detection

    func shouldEnableBGColor(for attributes: [NSAttributedString.Key : Any]) -> Bool {
        return hasBGTrait(for: attributes)
    }
    
    func hasBGTrait(for attributes: [NSAttributedString.Key : Any]) -> Bool {
        guard let color = attributes[.backgroundColor] as? UIColor,
            color == GenericElementConverter.emBGColor else {
            return false
        }
        return true
    }
}

