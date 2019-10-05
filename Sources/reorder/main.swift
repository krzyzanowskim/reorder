//
// swift run reorder -file Sources/Conference/Conference.swift > output.swift
// swift run reorder -index .build/x86_64-apple-macosx/debug/index/store
//

import Foundation
import Engine
import Utils

guard let executablePath = CommandLine.arguments.first else {
  fatalError("Missing executable")
}

let args = Array(CommandLine.arguments.dropFirst())
let commands = stride(from: 0, to: args.count - 1, by: 2).map { (command: args[$0].dropFirst(), value: args[$0+1]) }

var err = StderrOutputStream()
var out = StdoutOutputStream()

for (cmd, value) in commands {
  switch cmd {
  case "file":
    err.write("Processing \(value)\n")
    let content = try Data(contentsOf: URL(fileURLWithPath: value))
    let result = try Processor().process(content)
    out.write(result)
  case "index":
    err.write("Processing \(value)\n")
    for (path, content) in StoreIndexer(URL(fileURLWithPath: value)).process(symbolName: "Conference") {
      out.write("File: \(path)\n")
      out.write(content)
      out.write("\n")
    }
  default:
    err.write("Error: Unknown command: \(cmd)\n")
    exit(1)
  }
}
