public import Direction

extension Horizontal {

    public enum Alignment: Sendable, Hashable, CaseIterable {

        case leading

        case center

        case trailing
    }
}

extension Horizontal.Alignment {

    /// How far from the left of a measure a run of a width starts under this alignment, in a writing
    /// direction: left to right, nothing for `leading`, half of what the run leaves of the measure for
    /// `center`, and all of it for `trailing`; right to left, `leading` and `trailing` change places.
    @inlinable
    public func indent<Scalar: FloatingPoint>(of width: Scalar, in measure: Scalar, direction: Direction) -> Scalar {
        switch (self, direction) {
        case (.leading, .leftToRight), (.trailing, .rightToLeft): 0
        case (.center, _): (measure - width) / 2
        case (.trailing, .leftToRight), (.leading, .rightToLeft): measure - width
        }
    }
}

#if !hasFeature(Embedded)
    extension Horizontal.Alignment: Codable {}
#endif
