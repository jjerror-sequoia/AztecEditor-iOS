//
//  EmStringAttributeConverterTests.swift
//  AztecTests
//
//  Created by Kenson Yee on 7/31/20.
//  Copyright © 2020 Automattic Inc. All rights reserved.
//

import XCTest
@testable import Aztec

class EmStringAttributeConverterTests: XCTestCase {
    
    let converter = EmStringAttributeConverter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmphasisConversion() {
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.backgroundColor] = GenericElementConverter.emBGColor
        
        let elementNodes = converter.convert(attributes: attributes, andAggregateWith: [])
        
        XCTAssertEqual(elementNodes.count, 1)
        
        let emElement = elementNodes[0]
        XCTAssertEqual(emElement.type, .em)
        XCTAssertEqual(emElement.attributes.count, 0)
    }
    
    func testEmphasisConversionWithBadBGColor() {
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.backgroundColor] = UIColor.black

        let elementNodes = converter.convert(attributes: attributes, andAggregateWith: [])
        
        // Do NOT convert elements with other bg colors to EM
        XCTAssertEqual(elementNodes.count, 0)
    }

}
