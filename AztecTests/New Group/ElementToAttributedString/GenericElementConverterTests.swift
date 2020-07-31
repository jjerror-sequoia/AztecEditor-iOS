import XCTest
@testable import Aztec

class GenericElementConverterTests: XCTestCase {

    let converter = GenericElementConverter()
    let contentSerializer: ElementConverter.ContentSerializer = { elementNode, implicitRepresentation, attributes, intrinsicRepresentationBeforeChildren in
        return NSAttributedString()
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNewlineAfterUnsupportedElementInBlockLevelParent() {
        let childElementNode = ElementNode(type: .br)
        let attribute = Attribute(name: "someAttribute", value: .none)
        let elementNode = ElementNode(name: "unsupported", attributes: [attribute], children: [childElementNode])
        
        // The reason for having a parent element node, even if unused, is that it should force the unsupported element node
        // to have a newline after it when converted, since it's the last node in a block-level parent element.
        let parent = ElementNode(type: .p, attributes: [], children: [elementNode])
        
        // This is just to silence the warning that says `parent` is unused.
        let _ = parent
        
        let output = converter.convert(elementNode, inheriting: [:], contentSerializer: contentSerializer)
    
        XCTAssertEqual(output.length, 2)
        XCTAssertEqual(output.string.last, Character(.paragraphSeparator))
    }
    
    
    func testEmphasisElementNodeConversion() {
        let emphasisNode = ElementNode(type: .p, attributes: [], children: [
            ElementNode(type: .em, attributes: [], children: [ TextNode(text: "foo") ]),
        ])
        
        let serializer = AttributedStringSerializer()
        let output = converter.convert(emphasisNode, inheriting: [:], contentSerializer: serializer.contentSerializer)

        XCTAssertEqual(output.length, 3)
        
        var effectiveRange = NSRange()
        guard let bgColor = output.attribute(.backgroundColor, at: 0, effectiveRange: &effectiveRange) as? UIColor else {
            XCTFail("Expected a background color")
            return
        }

        XCTAssertEqual(bgColor, GenericElementConverter.emBGColor, "An unexpected background color was applied")
        XCTAssertEqual(effectiveRange, NSRange(location: 0, length: 3))
        
        let font = output.attribute(.font, at: 0, effectiveRange: nil) as? UIFont
        XCTAssertFalse(font?.containsTraits(.traitItalic) ?? false, "EM should NOT have italics")
    }
}
