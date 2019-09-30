import Foundation
import var Darwin.stdout

public struct StdoutOutputStream: TextOutputStream {
  public init() {}
  mutating public func write(_ string: String) {
    fputs(string, stdout)
  }
}

public struct StderrOutputStream: TextOutputStream {
  public init() {}
  mutating public func write(_ string: String) {
    fputs(string, stderr)
  }
}

public class StringOutputStream: TextOutputStream {
  public var string: String

  public init() {
    self.string = ""
  }

  public func write(_ string: String) {
    self.string.append(string)
  }
}
