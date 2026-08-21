public import Boundary_Primitives
public import Dimension_Primitives

public struct Corner: Sendable, Hashable, Codable {

    public var horizontal: Horizontal.Alignment.Side

    public var vertical: Vertical.Alignment.Side

    @inlinable
    public init(horizontal: Horizontal.Alignment.Side, vertical: Vertical.Alignment.Side) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension Horizontal.Alignment {

    public enum Side: Sendable, Hashable, Codable, CaseIterable {

        case leading

        case trailing
    }
}

extension Horizontal.Alignment.Side {

    @inlinable
    public static func opposite(_ side: Self) -> Self {
        switch side {
        case .leading: return .trailing
        case .trailing: return .leading
        }
    }

    @inlinable
    public var opposite: Self {
        Self.opposite(self)
    }
}

extension Horizontal {

    @inlinable
    public init(_ side: Horizontal.Alignment.Side, direction: Direction) {
        switch (side, direction) {
        case (.leading, .leftToRight), (.trailing, .rightToLeft):
            self = .leftward

        case (.trailing, .leftToRight), (.leading, .rightToLeft):
            self = .rightward
        }
    }
}

extension Vertical.Alignment {

    public enum Side: Sendable, Hashable, Codable, CaseIterable {

        case top

        case bottom
    }
}

extension Vertical.Alignment.Side {

    @inlinable
    public static func opposite(_ side: Self) -> Self {
        switch side {
        case .top: return .bottom
        case .bottom: return .top
        }
    }

    @inlinable
    public var opposite: Self {
        Self.opposite(self)
    }
}

extension Vertical {

    @inlinable
    public init(_ side: Vertical.Alignment.Side) {
        switch side {
        case .top: self = .upward
        case .bottom: self = .downward
        }
    }
}

extension Corner {

    public static let topLeading = Corner(horizontal: .leading, vertical: .top)

    public static let topTrailing = Corner(horizontal: .trailing, vertical: .top)

    public static let bottomLeading = Corner(horizontal: .leading, vertical: .bottom)

    public static let bottomTrailing = Corner(horizontal: .trailing, vertical: .bottom)
}

extension Corner: CaseIterable {

    public static let allCases: [Corner] = [
        .topLeading, .topTrailing, .bottomLeading, .bottomTrailing,
    ]
}

extension Corner {

    @inlinable
    public static func opposite(_ corner: Corner) -> Corner {
        Corner(horizontal: .opposite(corner.horizontal), vertical: .opposite(corner.vertical))
    }

    @inlinable
    public var opposite: Corner {
        Self.opposite(self)
    }

    @inlinable
    public static prefix func ! (value: Corner) -> Corner {
        value.opposite
    }
}

extension Corner {

    @inlinable
    public static func isTop(_ corner: Corner) -> Bool {
        corner.vertical == .top
    }

    @inlinable
    public var isTop: Bool { Self.isTop(self) }

    @inlinable
    public static func isBottom(_ corner: Corner) -> Bool {
        corner.vertical == .bottom
    }

    @inlinable
    public var isBottom: Bool { Self.isBottom(self) }

    @inlinable
    public static func isLeading(_ corner: Corner) -> Bool {
        corner.horizontal == .leading
    }

    @inlinable
    public var isLeading: Bool { Self.isLeading(self) }

    @inlinable
    public static func isTrailing(_ corner: Corner) -> Bool {
        corner.horizontal == .trailing
    }

    @inlinable
    public var isTrailing: Bool { Self.isTrailing(self) }
}

extension Corner {

    @inlinable
    public static func horizontalAdjacent(_ corner: Corner) -> Corner {
        Corner(horizontal: .opposite(corner.horizontal), vertical: corner.vertical)
    }

    @inlinable
    public var horizontalAdjacent: Corner {
        Self.horizontalAdjacent(self)
    }

    @inlinable
    public static func verticalAdjacent(_ corner: Corner) -> Corner {
        Corner(horizontal: corner.horizontal, vertical: .opposite(corner.vertical))
    }

    @inlinable
    public var verticalAdjacent: Corner {
        Self.verticalAdjacent(self)
    }
}

extension Boundary.Corner {

    @inlinable
    public init(_ corner: Corner, direction: Direction) {
        switch (Horizontal(corner.horizontal, direction: direction), Vertical(corner.vertical)) {
        case (.rightward, .upward): self = .topRight
        case (.leftward, .upward): self = .topLeft
        case (.rightward, .downward): self = .bottomRight
        case (.leftward, .downward): self = .bottomLeft
        }
    }
}
