public import Dimension

extension Layout.Line {

    public struct Box {

        public let height: Layout.Height

        public let ascent: Layout.Height

        public let descent: Layout.Height

        public let leading: Layout.Height
    }
}

extension Layout.Line.Box: Sendable where Scalar: Sendable {}
extension Layout.Line.Box: Equatable where Scalar: Equatable {}

extension Layout.Line.Box where Scalar: FloatingPoint {

    @inlinable
    public init(
        ascender: Layout.Height,
        descender: Layout.Height,
        height: Layout.Height
    ) {
        let leading = Layout.Height.max(.zero, (height - ascender - descender) / 2)
        self.height = height
        self.leading = leading
        self.ascent = leading + ascender
        self.descent = leading + descender
    }
}
