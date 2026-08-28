import Dimension
public import Layout
import Tagged
import Tagged_Standard_Library_Integration

private enum LayoutFlowGapsCodingKey: String, CodingKey {
    case item
    case line
}

extension Layout.Flow.Gaps: Codable where Scalar: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutFlowGapsCodingKey.self)
        self.init(
            item: try container.decode(Layout<Scalar, Space>.Width.self, forKey: .item),
            line: try container.decode(Layout<Scalar, Space>.Height.self, forKey: .line)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutFlowGapsCodingKey.self)
        try container.encode(item, forKey: .item)
        try container.encode(line, forKey: .line)
    }
}

private enum LayoutFlowCodingKey: String, CodingKey {
    case spacing
    case alignment
    case line
    case content
}

extension Layout.Flow: Codable where Scalar: Codable, Content: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutFlowCodingKey.self)
        self.init(
            spacing: try container.decode(Gaps.self, forKey: .spacing),
            alignment: try container.decode(Horizontal.Alignment.self, forKey: .alignment),
            line: try container.decode(Line.self, forKey: .line),
            content: try container.decode(Content.self, forKey: .content)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutFlowCodingKey.self)
        try container.encode(spacing, forKey: .spacing)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(line, forKey: .line)
        try container.encode(content, forKey: .content)
    }
}
