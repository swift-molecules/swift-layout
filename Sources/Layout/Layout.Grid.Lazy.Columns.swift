public import Geometry


extension Layout.Grid.Lazy {
    public enum Columns {

        case count(Int)

        case fractions([Scalar])

        case autoFill(minWidth: Scalar)

        case autoFit(minWidth: Scalar)
    }
}
