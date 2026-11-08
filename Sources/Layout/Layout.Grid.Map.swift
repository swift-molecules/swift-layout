import Geometry

extension Layout.Grid {
    public struct Map {
        @usableFromInline
        let grid: Layout<Scalar, Space>.Grid<Content>

        @usableFromInline
        init(grid: borrowing Layout<Scalar, Space>.Grid<Content>) {
            self.grid = copy grid
        }
    }
}
