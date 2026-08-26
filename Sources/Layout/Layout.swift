public import Geometry

public enum Layout<Scalar: ~Copyable, Space>: ~Copyable {}

extension Layout: Copyable where Scalar: Copyable {}
extension Layout: Sendable where Scalar: Sendable {}

extension Layout {

    public typealias Width = Geometry<Scalar, Space>.Width

    public typealias Height = Geometry<Scalar, Space>.Height

    public typealias Spacing = Geometry<Scalar, Space>.Magnitude

    public typealias Point = Geometry<Scalar, Space>.Point<2>

    public typealias Size = Geometry<Scalar, Space>.Size<2>
}
