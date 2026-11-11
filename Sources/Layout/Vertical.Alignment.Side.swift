public import Direction

extension Vertical.Alignment {
    public enum Side: Sendable, Hashable, CaseIterable {

        case top

        case bottom
    }
}

#if !hasFeature(Embedded)
    extension Vertical.Alignment.Side: Codable {}
#endif
