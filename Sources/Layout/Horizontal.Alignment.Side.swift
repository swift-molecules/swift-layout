public import Direction

extension Horizontal.Alignment {
    public enum Side: Sendable, Hashable, CaseIterable {

        case leading

        case trailing
    }
}

#if !hasFeature(Embedded)
    extension Horizontal.Alignment.Side: Codable {}
#endif
