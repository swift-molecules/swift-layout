// Axis+Layout.swift
// Spatial axis aliases for 2D Cartesian layout.

public import Axis_Primitives
import Dimension_Primitives

extension Axis where N == 2 {
    /// The horizontal axis (index 0, X).
    ///
    /// Alias for ``primary`` using spatial terminology standard in 2D Cartesian coordinates.
    @inlinable
    public static var horizontal: Self { .primary }

    /// The vertical axis (index 1, Y).
    ///
    /// Alias for ``secondary`` using spatial terminology standard in 2D Cartesian coordinates.
    @inlinable
    public static var vertical: Self { .secondary }
}
