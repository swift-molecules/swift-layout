public import Geometry

extension Layout.Grid {

    public struct Lazy {

        public var columns: Columns

        public var spacing: Gaps

        public var content: Content

        @inlinable
        public init(
            columns: consuming Columns,
            spacing: consuming Gaps,
            content: consuming Content
        ) {
            self.columns = columns
            self.spacing = spacing
            self.content = content
        }
    }
}

extension Layout.Grid.Lazy {

    public enum Columns {

        case count(Int)

        case fractions([Scalar])

        case autoFill(minWidth: Scalar)

        case autoFit(minWidth: Scalar)
    }
}

extension Layout.Grid.Lazy.Columns: Sendable where Scalar: Sendable {}
extension Layout.Grid.Lazy.Columns: Equatable where Scalar: Equatable {}
extension Layout.Grid.Lazy.Columns: Hashable where Scalar: Hashable {}
#if !hasFeature(Embedded)
    extension Layout.Grid.Lazy.Columns: Codable where Scalar: Codable {}
#endif

extension Layout.Grid.Lazy: Sendable where Scalar: Sendable, Content: Sendable {}

extension Layout.Grid.Lazy: Equatable where Scalar: Equatable, Content: Equatable {}

extension Layout.Grid.Lazy: Hashable where Scalar: Hashable, Content: Hashable {}

extension Layout.Grid.Lazy {

    @inlinable
    public static func columns(
        _ count: Int,
        spacing: Layout<Scalar, Space>.Grid<Content>.Gaps,
        content: Content
    ) -> Self {
        Self(columns: .count(count), spacing: spacing, content: content)
    }
}

extension Layout.Grid.Lazy where Scalar: AdditiveArithmetic {

    @inlinable
    public init(
        columns: consuming Columns,
        spacing: Layout<Scalar, Space>.Spacing,
        content: consuming Content
    ) {
        self.init(
            columns: columns,
            spacing: .uniform(spacing),
            content: content
        )
    }

    @inlinable
    public static func uniform(
        columns count: Int,
        spacing: Layout<Scalar, Space>.Spacing,
        content: Content
    ) -> Self {
        Self(columns: .count(count), spacing: .uniform(spacing), content: content)
    }
}

extension Layout.Grid.Lazy {

    @inlinable
    public static func map(_ grid: borrowing Layout<Scalar, Space>.Grid<Content>.Lazy) -> Map {
        Map(grid: grid)
    }

    @inlinable
    public var map: Map { Self.map(self) }

    public struct Map {
        @usableFromInline
        let grid: Layout<Scalar, Space>.Grid<Content>.Lazy

        @usableFromInline
        init(grid: borrowing Layout<Scalar, Space>.Grid<Content>.Lazy) {
            self.grid = copy grid
        }
    }
}

extension Layout.Grid.Lazy.Map {

    @inlinable
    public func content<Result, E: Swift.Error>(
        _ transform: (Content) throws(E) -> Result
    ) throws(E) -> Layout<Scalar, Space>.Grid<Result>.Lazy {
        Layout<Scalar, Space>.Grid<Result>.Lazy(
            columns: transformColumns(grid.columns),
            spacing: Layout<Scalar, Space>.Grid<Result>.Gaps(
                row: grid.spacing.row,
                column: grid.spacing.column
            ),
            content: try transform(grid.content)
        )
    }

    @usableFromInline
    func transformColumns<R>(
        _ columns: Layout<Scalar, Space>.Grid<Content>.Lazy.Columns
    ) -> Layout<Scalar, Space>.Grid<R>.Lazy.Columns {
        switch columns {
        case .count(let n):
            return .count(n)

        case .fractions(let f):
            return .fractions(f)

        case .autoFill(let minWidth):
            return .autoFill(minWidth: minWidth)

        case .autoFit(let minWidth):
            return .autoFit(minWidth: minWidth)
        }
    }
}
