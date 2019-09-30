import Foundation
import SwiftSyntax

class Indexer: SyntaxVisitor {

  private var functions: Array<DeclSyntax> = []

  func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind{
    self.functions.append(node)
    return .skipChildren
  }

  func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    self.functions.append(node)
    return .skipChildren
  }

  func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind  {
    self.functions.append(node)
    return .skipChildren
  }

  func sorted() -> Array<DeclSyntax> {
    self.functions.sorted(by: { (lhs, rhs) -> Bool in
      // public > internal > private, fileprivate

      var lhsVisitor = Visitor()
      lhs.walk(&lhsVisitor)

      var rhsVisitor = Visitor()
      rhs.walk(&rhsVisitor)

      switch (lhsVisitor.accessLevel, rhsVisitor.accessLevel) {
      case (.privateKeyword, .publicKeyword):
        return false
      case (.privateKeyword, .internalKeyword):
        return false
      case (.internalKeyword, .publicKeyword):
        return false
      case (.internalKeyword, .privateKeyword):
        return true
      case (.publicKeyword, .internalKeyword):
        return true
      case (.publicKeyword, .privateKeyword):
        return true
      default:
        return false
      }
    }).sorted(by: { (lhs, rhs) -> Bool in
      // init > deinit > func

      var lhsVisitor = Visitor()
      lhs.walk(&lhsVisitor)

      var rhsVisitor = Visitor()
      rhs.walk(&rhsVisitor)

      if lhsVisitor.isInit && rhsVisitor.isFunc {
        return true
      } else if lhsVisitor.isInit && rhsVisitor.isDeinit {
        return true
      } else if lhsVisitor.isDeinit && rhsVisitor.isFunc {
        return true
      } else if lhsVisitor.isDeinit && rhsVisitor.isInit {
        return false
      } else if lhsVisitor.isFunc && rhsVisitor.isInit {
        return false
      } else if lhsVisitor.isFunc && rhsVisitor.isDeinit {
        return false
      }
      return false
    })
  }
}
