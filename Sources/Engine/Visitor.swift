import Foundation
import SwiftSyntax

struct Visitor: SyntaxVisitor {
  var accessLevel: TokenKind = .internalKeyword
  var isFunc: Bool = false
  var isInit: Bool = false
  var isDeinit: Bool = false

  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    self.isInit = true
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    self.isDeinit = true
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    self.isFunc = true
    self.process(node.modifiers)
    return .skipChildren
  }

  private mutating func process(_ modifiers: ModifierListSyntax?) {
    guard let modifiers = modifiers else {
      return self.accessLevel = .internalKeyword
    }
    let isPrivate = modifiers.contains(where: { $0.name.tokenKind == .privateKeyword || $0.name.tokenKind == .fileprivateKeyword })
    let isPublic = modifiers.contains(where: { $0.name.tokenKind == .publicKeyword })
    var isInternal = modifiers.contains(where: { $0.name.tokenKind == .internalKeyword })

    if !isInternal && !isPrivate && !isPublic {
      isInternal = true
    }

    if isPublic {
      self.accessLevel = .publicKeyword
    } else if isPrivate {
      self.accessLevel = .privateKeyword
    } else if isInternal {
      self.accessLevel = .internalKeyword
    }
  }
}
