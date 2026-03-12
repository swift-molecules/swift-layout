// Layout.Line.Box.swift
// Line box geometry following the half-leading model.

public import Dimension_Primitives

extension Layout.Line {
    /// Line box geometry following the half-leading model.
    ///
    /// Computes the vertical space allocation for a line of content
    /// given font metrics and a target line height. The half-leading
    /// model distributes extra space symmetrically above and below
    /// the content area (ascender + |descender|).
    ///
    /// ## Geometric Relationships
    ///
    /// ```
    /// ┌─────────────────────────┐ ← Line box top
    /// │     leading             │
    /// ├─────────────────────────┤ ← Ascender line
    /// │     ascender            │
    /// ├─────────────────────────┤ ← BASELINE
    /// │     |descender|         │
    /// ├─────────────────────────┤ ← Descender line
    /// │     leading             │
    /// └─────────────────────────┘ ← Line box bottom
    /// ```
    ///
    /// ## Formulas
    ///
    /// - `leading = max(0, (height - ascender - |descender|) / 2)`
    /// - `ascent = leading + ascender`
    /// - `descent = leading + |descender|`
    ///
    /// ## Reference
    ///
    /// CSS 2.1 Section 10.8 — Line height calculations
    public struct Box {
        /// Total height of the line box.
        public let height: Layout.Height

        /// Distance from the top of the line box to the baseline.
        ///
        /// Equals: `leading + ascender`
        public let ascent: Layout.Height

        /// Distance from the baseline to the bottom of the line box.
        ///
        /// Equals: `leading + |descender|`
        public let descent: Layout.Height

        /// Half of the total leading, distributed symmetrically
        /// above and below the content area.
        ///
        /// `leading = max(0, (height - ascender - |descender|) / 2)`
        public let leading: Layout.Height
    }
}

extension Layout.Line.Box: Sendable where Scalar: Sendable {}
extension Layout.Line.Box: Equatable where Scalar: Equatable {}

extension Layout.Line.Box where Scalar: FloatingPoint {
    /// Create a line box from ascender, descender, and target height.
    ///
    /// - Parameters:
    ///   - ascender: Distance from baseline to top of tallest glyph (positive).
    ///   - descender: Distance from baseline to bottom of lowest glyph (positive magnitude).
    ///   - height: Target total line height.
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
