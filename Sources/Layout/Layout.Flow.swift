public import Dimension
public import Geometry

extension Layout {

    public struct Flow<Content> {

        public var spacing: Gaps

        public var alignment: Horizontal.Alignment

        public var line: Line

        public var content: Content

        @inlinable
        public init(
            spacing: consuming Gaps,
            alignment: consuming Horizontal.Alignment,
            line: consuming Line,
            content: consuming Content
        ) {
            self.spacing = spacing
            self.alignment = alignment
            self.line = line
            self.content = content
        }
    }
}

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
#if !hasFeature(Embedded)
    extension Layout.Flow.Gaps: Codable where Scalar: Codable {}
#endif

extension Layout.Flow.Gaps where Scalar: AdditiveArithmetic {

    @inlinable
    public static func uniform(_ value: Layout.Spacing) -> Self {
        Self(item: value.width, line: value.height)
    }
}

extension Layout.Flow {

    public struct Line: Sendable, Hashable, Codable {

        public var alignment: Vertical.Alignment

        @inlinable
        public init(alignment: Vertical.Alignment) {
            self.alignment = alignment
        }
    }
}

extension Layout.Flow.Line {

    @inlinable
    public static var top: Self { Self(alignment: .top) }

    @inlinable
    public static var center: Self { Self(alignment: .center) }

    @inlinable
    public static var bottom: Self { Self(alignment: .bottom) }
}

extension Layout.Flow: Sendable where Scalar: Sendable, Content: Sendable {}

extension Layout.Flow: Equatable where Scalar: Equatable, Content: Equatable {}

extension Layout.Flow: Hashable where Scalar: Hashable, Content: Hashable {}

#if !hasFeature(Embedded)
    extension Layout.Flow: Codable where Scalar: Codable, Content: Codable {}
#endif

extension Layout.Flow {

    @inlinable
    public init(
        spacing: consuming Gaps,
        content: consuming Content
    ) {
        self.init(
            spacing: spacing,
            alignment: .leading,
            line: .top,
            content: content
        )
    }
}

extension Layout.Flow where Scalar: AdditiveArithmetic {

    @inlinable
    public static func uniform(
        spacing: Layout.Spacing,
        alignment: Horizontal.Alignment = .leading,
        content: Content
    ) -> Self {
        Self(
            spacing: .uniform(spacing),
            alignment: alignment,
            line: .top,
            content: content
        )
    }
}

extension Layout.Flow {

    @inlinable
    public static func map(_ flow: borrowing Layout<Scalar, Space>.Flow<Content>) -> Map {
        Map(flow: flow)
    }

    @inlinable
    public var map: Map { Self.map(self) }

    public struct Map {
        @usableFromInline
        let flow: Layout<Scalar, Space>.Flow<Content>

        @usableFromInline
        init(flow: borrowing Layout<Scalar, Space>.Flow<Content>) {
            self.flow = copy flow
        }
    }
}

extension Layout.Flow.Map {

    @inlinable
    public func content<Result, E: Swift.Error>(
        _ transform: (Content) throws(E) -> Result
    ) throws(E) -> Layout<Scalar, Space>.Flow<Result> {
        Layout<Scalar, Space>.Flow<Result>(
            spacing: Layout<Scalar, Space>.Flow<Result>.Gaps(
                item: flow.spacing.item,
                line: flow.spacing.line
            ),
            alignment: flow.alignment,
            line: Layout<Scalar, Space>.Flow<Result>.Line(alignment: flow.line.alignment),
            content: try transform(flow.content)
        )
    }
}
