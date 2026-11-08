import Geometry

extension Layout.Grid.Lazy {
    public enum Columns {

        case count(Int)

        case fractions([Scalar])

        case autoFill(minWidth: Scalar)

        case autoFit(minWidth: Scalar)
    }
}

extension Layout.Grid.Lazy.Columns: Sendable where Scalar: Sendable {}
extension Layout.Grid.Lazy.Columns: Equatable where Scalar: Equatable {}
extension Layout.Grid.Lazy.Columns: Hashable where Scalar: Hashable {}
#if !hasFeature(Embedded)
    extension Layout.Grid.Lazy.Columns: Codable where Scalar: Codable {}
#endif
