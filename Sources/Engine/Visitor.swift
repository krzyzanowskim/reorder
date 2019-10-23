import Foundation
import SwiftSyntax

struct Visitor: SyntaxVisitor {

  enum FakeTokenKind : Int, Comparable {
    static func < (lhs: Visitor.FakeTokenKind, rhs: Visitor.FakeTokenKind) -> Bool {
      return lhs.rawValue < rhs.rawValue
    }

    case publicKeyword = 0
    case internalKeyword = 1
    case privateKeyword = 2
    case fileprivateKeyword = 3
    case other = 99
  }
  
  var accessLevel: FakeTokenKind = .other
  
  enum DeclSyntaxKind : Int, Comparable {
    static func < (lhs: Visitor.DeclSyntaxKind, rhs: Visitor.DeclSyntaxKind) -> Bool {
      return lhs.rawValue < rhs.rawValue
    }
    
    case isTypeAlias = 0
    case isVariable = 10
    case isInit = 20
    case isDeinit = 30
    case isEnum = 40
    case isFunc = 70
    case other = 999
  }
  
  var declSyntax : DeclSyntaxKind = .other

  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isVariable
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isInit
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isDeinit
    self.process(node.modifiers)
    return .skipChildren
  }
  
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isFunc
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isTypeAlias
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isEnum
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
