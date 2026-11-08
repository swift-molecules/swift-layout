public import Direction
public import Geometry

extension Layout.Flow {
    public struct Gaps {

        public var item: Layout.Width

        public var line: Layout.Height

        @inlinable
        public init(item: Layout.Width, line: Layout.Height) {
            self.item = item
            self.line = line
        }
    }
}
