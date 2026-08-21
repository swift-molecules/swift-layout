public import Geometry_Primitives

extension Layout {

    public struct Grid<Content> {

        public var spacing: Gaps

        public var alignment: Alignment

        public var content: Content

        @inlinable
        public init(
            spacing: consuming Gaps,
            alignment: consuming Alignment,
            content: consuming Content
        ) {
            self.spacing = spacing
            self.alignment = alignment
            self.content = content
        }
    }
}

extension Layout.Grid {

    public struct Gaps {

        public var row: Layout.Height

        public var column: Layout.Width

        @inlinable
        public init(row: Layout.Height, column: Layout.Width) {
            self.row = row
            self.column = column
        }
    }
}

extension Layout.Grid.Gaps: Sendable where Scalar: Sendable {}
extension Layout.Grid.Gaps: Equatable where Scalar: Equatable {}
extension Layout.Grid.Gaps: Hashable where Scalar: Hashable {}
#if !hasFeature(Embedded)
    extension Layout.Grid.Gaps: Codable where Scalar: Codable {}
#endif

extension Layout.Grid.Gaps where Scalar: AdditiveArithmetic {

    @inlinable
    public static func uniform(_ value: Layout.Spacing) -> Self {
        Self(row: value.height, column: value.width)
    }
}

extension Layout.Grid: Sendable where Scalar: Sendable, Content: Sendable {}

extension Layout.Grid: Equatable where Scalar: Equatable, Content: Equatable {}

extension Layout.Grid: Hashable where Scalar: Hashable, Content: Hashable {}

#if !hasFeature(Embedded)
    extension Layout.Grid: Codable where Scalar: Codable, Content: Codable {}
#endif

extension Layout.Grid {

    @inlinable
    public init(
        spacing: consuming Gaps,
        content: consuming Content
    ) {
        self.init(
            spacing: spacing,
            alignment: .center,
            content: content
        )
    }
}

extension Layout.Grid where Scalar: AdditiveArithmetic {

    @inlinable
    public static func uniform(
        spacing: Layout.Spacing,
        alignment: Alignment = .center,
        content: Content
    ) -> Self {
        Self(
            spacing: .uniform(spacing),
            alignment: alignment,
            content: content
        )
    }
}

extension Layout.Grid {

    @inlinable
    public static func map(_ grid: borrowing Layout<Scalar, Space>.Grid<Content>) -> Map {
        Map(grid: grid)
    }

    @inlinable
    public var map: Map { Self.map(self) }

    public struct Map {
        @usableFromInline
        let grid: Layout<Scalar, Space>.Grid<Content>

        @usableFromInline
        init(grid: borrowing Layout<Scalar, Space>.Grid<Content>) {
            self.grid = copy grid
        }
    }
}

extension Layout.Grid.Map {

    @inlinable
    public func content<Result, E: Swift.Error>(
        _ transform: (Content) throws(E) -> Result
    ) throws(E) -> Layout<Scalar, Space>.Grid<Result> {
        Layout<Scalar, Space>.Grid<Result>(
            spacing: Layout<Scalar, Space>.Grid<Result>.Gaps(
                row: grid.spacing.row,
                column: grid.spacing.column
            ),
            alignment: grid.alignment,
            content: try transform(grid.content)
        )
    }
}
