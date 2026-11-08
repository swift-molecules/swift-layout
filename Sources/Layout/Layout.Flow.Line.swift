public import Direction
import Geometry

extension Layout.Flow {
    public struct Line: Sendable, Hashable, Codable {

        public var alignment: Vertical.Alignment

        @inlinable
        public init(alignment: Vertical.Alignment) {
            self.alignment = alignment
        }
    }
}
