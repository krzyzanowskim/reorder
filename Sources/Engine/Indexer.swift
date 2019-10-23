import Foundation
import SwiftSyntax

class Indexer: SyntaxVisitor {

  private var functions: Array<DeclSyntax> = []
  
  func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind{
    self.functions.append(node)
    return .skipChildren
  }
  
  func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind{
    self.functions.append(node)
    return .skipChildren
  }

  func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind{
    self.functions.append(node)
    return .skipChildren
  }

  func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind{
    self.functions.append(node)
    return .skipChildren
  }

//  func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind{
//    self.functions.append(node)
//    return .skipChildren
//  }

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

  func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind  {
    self.functions.append(node)
    return .skipChildren
  }
  
  func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind  {
    self.functions.append(node)
    return .skipChildren
  }
  
  func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind  {
    self.functions.append(node)
    return .skipChildren
  }

  func sorted() -> Array<DeclSyntax> {
    self.functions.sorted(by: { (lhs, rhs) -> Bool in

      var lhsVisitor = Visitor()
      lhs.walk(&lhsVisitor)

      var rhsVisitor = Visitor()
      rhs.walk(&rhsVisitor)

      return lhsVisitor.accessLevel < rhsVisitor.accessLevel
    }).sorted(by: { (lhs, rhs) -> Bool in
      
      var lhsVisitor = Visitor()
      lhs.walk(&lhsVisitor)

      var rhsVisitor = Visitor()
      rhs.walk(&rhsVisitor)

      return lhsVisitor.declSyntax < rhsVisitor.declSyntax
    })
  }
}
