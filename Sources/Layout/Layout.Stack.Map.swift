public import Axis
import Direction


extension Layout.Stack {
    public struct Map {
        @usableFromInline
        let stack: Layout<Scalar, Space>.Stack<Content>

        @usableFromInline
        init(stack: borrowing Layout<Scalar, Space>.Stack<Content>) {
            self.stack = copy stack
        }
    }
}
