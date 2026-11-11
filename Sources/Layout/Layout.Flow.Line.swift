public import Direction
import Geometry

extension Layout.Flow {
    public struct Line: Sendable, Hashable {

        public var alignment: Vertical.Alignment

        @inlinable
        public init(alignment: Vertical.Alignment) {
            self.alignment = alignment
        }
    }
}

#if !hasFeature(Embedded)
    extension Layout.Flow.Line: Codable {}
#endif
