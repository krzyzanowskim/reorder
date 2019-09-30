import XCTest
import class Foundation.Bundle
@testable import Engine

final class ReorderSwiftSyntaxTests: XCTestCase {

  /// Returns path to the built products directory.
  private var productsDirectory: URL {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
          return bundle.bundleURL.deletingLastPathComponent()
      }
      fatalError("couldn't find the products directory")
    #else
      return Bundle.main.bundleURL
    #endif
  }

  private lazy var exampleFileURL = self.productsDirectory.appendingPathComponent("../../../Sources/Conference/Conference.swift")

  func testExampleFile() {
    XCTAssertTrue(FileManager.default.fileExists(atPath: self.exampleFileURL.path))
  }

  func testReorder() throws {
    let content = try Data(contentsOf: self.exampleFileURL)
    XCTAssertGreaterThan(content.count, 0)

    let result = try Processor().process(content)
    print(result)
  }

  static var allTests = [
      ("testExampleFile", testExampleFile,
        "testReorder", testReorder),
  ]
}
