import Foundation

public class Conference {
  public var name: String
  public let venue: String

  internal typealias Line = String

  private var attendees: Set<String>
  private var sponsors: Set<String>
  private var costs: Array<Decimal>

  internal func add(attendee: String) {
    self.attendees.insert(attendee)
  }

  internal func add(sponsor: String) {
    self.sponsors.insert(sponsor)
  }

  deinit {
    fatalError("Thank you for playing Wing Commander")
  }

  internal func add(cost: Decimal) {
    self.costs.append(cost)
  }

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
}
