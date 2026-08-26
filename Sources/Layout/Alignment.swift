public import Dimension

public struct Alignment: Sendable, Hashable, Codable {

    public var horizontal: Horizontal.Alignment

    public var vertical: Vertical.Alignment

    @inlinable
    public init(horizontal: Horizontal.Alignment, vertical: Vertical.Alignment) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension Alignment {

    public static let topLeading = Self(horizontal: .leading, vertical: .top)

    public static let top = Self(horizontal: .center, vertical: .top)

    public static let topTrailing = Self(horizontal: .trailing, vertical: .top)

    public static let leading = Self(horizontal: .leading, vertical: .center)

    public static let center = Self(horizontal: .center, vertical: .center)

    public static let trailing = Self(horizontal: .trailing, vertical: .center)

    public static let bottomLeading = Self(horizontal: .leading, vertical: .bottom)

    public static let bottom = Self(horizontal: .center, vertical: .bottom)

    public static let bottomTrailing = Self(horizontal: .trailing, vertical: .bottom)
}
