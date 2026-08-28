import Axis
import Axis_Standard_Library_Integration
import Dimension
public import Layout
import Tagged
import Tagged_Standard_Library_Integration

private enum LayoutStackCodingKey: String, CodingKey {
    case axis
    case spacing
    case alignment
    case content
}

extension Layout.Stack: Codable where Scalar: Codable, Content: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutStackCodingKey.self)
        self.init(
            axis: try container.decode(Axis<2>.self, forKey: .axis),
            spacing: try container.decode(Layout<Scalar, Space>.Spacing.self, forKey: .spacing),
            alignment: try container.decode(Cross.Alignment.self, forKey: .alignment),
            content: try container.decode(Content.self, forKey: .content)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutStackCodingKey.self)
        try container.encode(axis, forKey: .axis)
        try container.encode(spacing, forKey: .spacing)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(content, forKey: .content)
    }
}
