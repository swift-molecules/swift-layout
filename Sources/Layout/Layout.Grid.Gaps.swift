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
