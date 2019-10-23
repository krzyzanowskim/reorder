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
    
    case isImport = 0
    case isAssociatedtype = 1
    case isTypealias = 2
    case isVariable = 10
    case isInitializer = 20
    case isDeinitializer = 30
    case isEnum = 40
    case isFunction = 70
    case isSubscript = 71
    case isOperator = 80
    case isPrecedenceGroup = 81
    case notReordered = 999
  }
  
  var declSyntax : DeclSyntaxKind = .notReordered

  mutating func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isAssociatedtype
    self.process(node.modifiers)
    return .skipChildren
  }
  
  mutating func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isSubscript
    self.process(node.modifiers)
    return .skipChildren
  }

//  mutating func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
//    
//    self.declSyntax = .isImport
//    self.process(node.modifiers)
//    return .skipChildren
//  }

  mutating func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isOperator
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isPrecedenceGroup
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isVariable
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isInitializer
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isDeinitializer
    self.process(node.modifiers)
    return .skipChildren
  }
  
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isFunction
    self.process(node.modifiers)
    return .skipChildren
  }

  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    
    self.declSyntax = .isTypealias
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
    
    let isFilePrivate = modifiers.contains(where: { $0.name.tokenKind == .fileprivateKeyword })
    let isPrivate = modifiers.contains(where: { $0.name.tokenKind == .privateKeyword })
    let isPublic = modifiers.contains(where: { $0.name.tokenKind == .publicKeyword })

    if isPublic {
      self.accessLevel = .publicKeyword
    } else if isPrivate {
      self.accessLevel = .privateKeyword
    } else if isFilePrivate {
      self.accessLevel = .fileprivateKeyword
    } else {
      self.accessLevel = .internalKeyword
    }
  }
}
