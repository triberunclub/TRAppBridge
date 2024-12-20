import XCTest
@testable import TRAppBridge

final class TRAppBridgeTests: XCTestCase {
    func testExample() {
        // This is an example test case
        XCTAssertNotNil(TRAppBridge.shared)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}