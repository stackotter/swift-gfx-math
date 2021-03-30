import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MatrixTests.allTests),
        testCase(VectorProtocolTests.allTests),
        testCase(RectTests.allTests),
        testCase(QuaternionTests.allTests)
    ]
}
#endif
