import Foundation
import SwiftSyntax

class Rewriter: SyntaxRewriter {
  private let indexer: Indexer
  private var sortedFunctions: Array<DeclSyntax>

  init(_ indexer: Indexer) {
    self.indexer = indexer
    self.sortedFunctions = indexer.sorted()
  }

  override func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }
  
  override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }

  override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
    sortedFunctions.removeFirst()
  }
}
