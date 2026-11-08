import Direction
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

extension Layout.Flow.Gaps: Sendable where Scalar: Sendable {}
extension Layout.Flow.Gaps: Equatable where Scalar: Equatable {}
extension Layout.Flow.Gaps: Hashable where Scalar: Hashable {}
