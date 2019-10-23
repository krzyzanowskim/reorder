
public class Conference {

  public enum FooPublic {}
  internal enum FooInternal {}
  private enum FooPrivate {}
  
  internal typealias Line = String

  internal func add(attendee: String) {
    self.attendees.insert(attendee)
  }

  internal func add(sponsor: String) {
    self.sponsors.insert(sponsor)
  }
  private var sponsors: Set<String>

  deinit {
    fatalError("Thank you for playing Wing Commander")
  }
  public var name: String

  internal func add(cost: Decimal) {
    self.costs.append(cost)
  }

  private var costs: Array<Decimal>

  private init() {
    self.name = "FrenchKit"
    self.venue = "Bâtiment"
    self.attendees = []
    self.sponsors = []
    self.costs = []
  }

  public func totalCosts() -> Decimal {
    self.costs.reduce(0, { $0 + $1 })
  }

  private func statement() -> Array<Line> {
    var lines: Array<Line> = []

    for attendee in self.attendees {
      lines.append("Attendee:\t\(attendee)")
    }

    for sponsor in self.sponsors {
      lines.append("Sponsor:\t\(sponsor)")
    }

    for cost in self.costs {
      lines.append("Cost:\t€\(cost)")
    }

    return lines
  }

  public let venue: String

  internal func printStatement() {
    self.statement().forEach({
      print($0)
    })
  }

  public init(name: String, venue: String) {
    self.name = name
    self.venue = venue
    self.attendees = []
    self.sponsors = []
    self.costs = []
  }
  
  fileprivate var attendees: Set<String>
}

protocol Container {
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    associatedtype Item
}

import Foundation
