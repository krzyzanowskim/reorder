import Foundation
import SwiftSyntax

extension TokenSequence: CustomDebugStringConvertible {
  public var debugDescription: String {
    self.reduce("") { (res: String, token: TokenSyntax) -> String in
      res + token.text + " "
    }
  }
}
