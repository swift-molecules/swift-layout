public import Geometry

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
