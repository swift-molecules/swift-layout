public import Direction

extension Horizontal {

    public enum Alignment: Sendable, Hashable, CaseIterable {

        case leading

        case center

        case trailing
    }
}

#if !hasFeature(Embedded)
    extension Horizontal.Alignment: Codable {}
#endif
