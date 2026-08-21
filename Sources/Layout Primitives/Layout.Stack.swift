public import Axis_Primitives
import Dimension_Primitives

extension Layout {

    public struct Stack<Content> {

        public var axis: Axis<2>

        public var spacing: Spacing

        public var alignment: Cross.Alignment

        public var content: Content

        @inlinable
        public init(
            axis: consuming Axis<2>,
            spacing: consuming Spacing,
            alignment: consuming Cross.Alignment,
            content: consuming Content
        ) {
            self.axis = axis
            self.spacing = spacing
            self.alignment = alignment
            self.content = content
        }
    }
}

extension Layout.Stack: Sendable where Scalar: Sendable, Content: Sendable {}

extension Layout.Stack: Equatable where Scalar: Equatable, Content: Equatable {}

extension Layout.Stack: Hashable where Scalar: Hashable, Content: Hashable {}

#if !hasFeature(Embedded)
    extension Layout.Stack: Codable where Scalar: Codable, Content: Codable {}
#endif

extension Layout.Stack {

    @inlinable
    public static func vertical(
        spacing: Layout.Spacing,
        alignment: Cross.Alignment = .center,
        content: Content
    ) -> Self {
        Self(axis: .secondary, spacing: spacing, alignment: alignment, content: content)
    }

    @inlinable
    public static func horizontal(
        spacing: Layout.Spacing,
        alignment: Cross.Alignment = .center,
        content: Content
    ) -> Self {
        Self(axis: .primary, spacing: spacing, alignment: alignment, content: content)
    }
}

extension Layout.Stack {

    @inlinable
    public static func map(_ stack: borrowing Layout<Scalar, Space>.Stack<Content>) -> Map {
        Map(stack: stack)
    }

    @inlinable
    public var map: Map { Self.map(self) }

    public struct Map {
        @usableFromInline
        let stack: Layout<Scalar, Space>.Stack<Content>

        @usableFromInline
        init(stack: borrowing Layout<Scalar, Space>.Stack<Content>) {
            self.stack = copy stack
        }
    }
}

extension Layout.Stack.Map {

    @inlinable
    public func content<Result, E: Swift.Error>(
        _ transform: (Content) throws(E) -> Result
    ) throws(E) -> Layout<Scalar, Space>.Stack<Result> {
        Layout<Scalar, Space>.Stack<Result>(
            axis: stack.axis,
            spacing: stack.spacing,
            alignment: stack.alignment,
            content: try transform(stack.content)
        )
    }
}
