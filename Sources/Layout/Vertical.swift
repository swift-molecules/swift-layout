public import Direction

extension Vertical {

    public enum Baseline: Sendable, Hashable, CaseIterable {

        case first

        case last
    }
}

extension Vertical {

    public enum Alignment: Sendable, Hashable {

        case top

        case center

        case bottom

        case baseline(Vertical.Baseline)
    }
}

extension Vertical.Alignment {

    @inlinable
    public static var firstBaseline: Self { .baseline(.first) }

    @inlinable
    public static var lastBaseline: Self { .baseline(.last) }
}

extension Vertical.Alignment: CaseIterable {

    public static var allCases: [Vertical.Alignment] {
        [.top, .center, .bottom, .baseline(.first), .baseline(.last)]
    }
}

#if !hasFeature(Embedded)
    extension Vertical.Baseline: Codable {}
    extension Vertical.Alignment: Codable {}
#endif
