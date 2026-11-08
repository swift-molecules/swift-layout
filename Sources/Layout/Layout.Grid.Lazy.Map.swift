public import Geometry


extension Layout.Grid.Lazy {
    public struct Map {
        @usableFromInline
        let grid: Layout<Scalar, Space>.Grid<Content>.Lazy

        @usableFromInline
        init(grid: borrowing Layout<Scalar, Space>.Grid<Content>.Lazy) {
            self.grid = copy grid
        }
    }
}
