#if Boundary
    public import Boundary
    public import Direction

    extension Boundary.Corner {

        @inlinable
        public init(_ corner: Layout::Corner, direction: Layout::Direction) {
            switch (Horizontal(corner.horizontal, direction: direction), Vertical(corner.vertical)) {
            case (.rightward, .upward): self = .topRight
            case (.leftward, .upward): self = .topLeft
            case (.rightward, .downward): self = .bottomRight
            case (.leftward, .downward): self = .bottomLeft
            }
        }
    }
#endif
