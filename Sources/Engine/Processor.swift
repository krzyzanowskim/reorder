import Foundation
import SwiftSyntax
import Utils

public class Processor {

  private struct Error: Swift.Error {
    static let invalidInput = Error()
  }

  public init() {
  }

  public func process(_ data: Data) throws -> String {
    guard let source = String(data: data, encoding: .utf8) else {
      throw Error.invalidInput
    }

    let parsed: SourceFileSyntax = try SyntaxParser.parse(source: source)

    // Gather information about the file
    var visitor = Indexer()
    parsed.walk(&visitor)

    // Reqrite file using visitor
    let rewritten = Rewriter(visitor).visit(parsed)

    var output = StringOutputStream()
    rewritten.write(to: &output)
    return output.string
  }
}
