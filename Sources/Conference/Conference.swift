import Foundation

public class Conference {
  internal typealias Line = String

  public var name: String
  public let venue: String
  private var sponsors: Set<String>
  private var costs: Array<Decimal>
  fileprivate var attendees: Set<String>

  public init(name: String, venue: String) {
    self.name = name
    self.venue = venue
    self.attendees = []
    self.sponsors = []
    self.costs = []
  }

  private init() {
    self.name = "FrenchKit"
    self.venue = "Bâtiment"
    self.attendees = []
    self.sponsors = []
    self.costs = []
  }

  deinit {
    fatalError("Thank you for playing Wing Commander")
  }

  public enum FooPublic {}
  internal enum FooInternal {}
  private enum FooPrivate {}

  public func totalCosts() -> Decimal {
    self.costs.reduce(0, { $0 + $1 })
  }

  internal func add(attendee: String) {
    self.attendees.insert(attendee)
  }

  internal func add(sponsor: String) {
    self.sponsors.insert(sponsor)
  }

  internal func add(cost: Decimal) {
    self.costs.append(cost)
  }

  internal func printStatement() {
    self.statement().forEach({
      print($0)
    })
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
}
