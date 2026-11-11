extension Cross {
    public enum Alignment: Sendable, Hashable, CaseIterable {

        case leading

        case center

        case trailing

        case fill
    }
}

#if !hasFeature(Embedded)
    extension Cross.Alignment: Codable {}
#endif
