public import Axis
import Dimension

extension Axis where N == 2 {

    @inlinable
    public static var horizontal: Self { .primary }

    @inlinable
    public static var vertical: Self { .secondary }
}
