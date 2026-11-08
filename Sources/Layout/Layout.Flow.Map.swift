public import Direction
public import Geometry

extension Layout.Flow {
    public struct Map {
        @usableFromInline
        let flow: Layout<Scalar, Space>.Flow<Content>

        @usableFromInline
        init(flow: borrowing Layout<Scalar, Space>.Flow<Content>) {
            self.flow = copy flow
        }
    }
}
