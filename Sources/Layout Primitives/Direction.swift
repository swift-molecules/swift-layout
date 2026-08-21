public enum Direction: Sendable, Hashable, Codable, CaseIterable {

    case leftToRight

    case rightToLeft
}

extension Direction {

    public static var ltr: Self { .leftToRight }

    public static var rtl: Self { .rightToLeft }
}

extension Direction {

    @inlinable
    public static func opposite(_ direction: Direction) -> Direction {
        switch direction {
        case .leftToRight: return .rightToLeft
        case .rightToLeft: return .leftToRight
        }
    }

    @inlinable
    public var opposite: Direction {
        Self.opposite(self)
    }
}
