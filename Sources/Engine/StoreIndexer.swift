//
//  File.swift
//  
//
//  Created by Marcin Krzyzanowski on 05/10/2019.
//

import Foundation
import IndexStoreDB

public struct StoreIndexer {

  public typealias Path = String

  public struct Function {
    public let symbol: Symbol
    public let location: SymbolLocation
  }

  private let indexURL: URL

  public init(_ indexURL: URL) {
    self.indexURL = indexURL
  }

  public func process(symbolName: String) -> [Path: String] {
    guard let lib = try? IndexStoreLibrary(dylibPath: "/Applications/Xcode_11.1_GM.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libIndexStore.dylib"),
        let index = try? IndexStoreDB(storePath: indexURL.path, databasePath: NSTemporaryDirectory() + "index_\(getpid())", library: lib, listenToUnitEvents: false)
      else {
        fatalError("Cannot process.")
    }

    index.pollForUnitChangesAndWait()

    let functions = index.canonicalOccurrences(ofName: symbolName).flatMap {
      index.occurrences(relatedToUSR: $0.symbol.usr, roles: .all)
       .filter({ $0.symbol.kind == .instanceMethod && !$0.roles.contains(.implicit) })
       .map({ Function(symbol: $0.symbol, location: $0.location) })
    }

    let filesDictionary = Dictionary(grouping: functions, by: { $0.location.path })

    var output: [Path: String] = [:]
    
    for filePath in filesDictionary.keys {
      output[filePath] = try? Processor().process(Data.init(contentsOf: URL(fileURLWithPath: filePath)))
    }

    return output
  }
}
