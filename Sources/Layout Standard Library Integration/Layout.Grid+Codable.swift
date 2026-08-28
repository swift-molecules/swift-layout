import Dimension
public import Layout
import Tagged
import Tagged_Standard_Library_Integration

private enum LayoutGridGapsCodingKey: String, CodingKey {
    case row
    case column
}

extension Layout.Grid.Gaps: Codable where Scalar: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutGridGapsCodingKey.self)
        self.init(
            row: try container.decode(Layout<Scalar, Space>.Height.self, forKey: .row),
            column: try container.decode(Layout<Scalar, Space>.Width.self, forKey: .column)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutGridGapsCodingKey.self)
        try container.encode(row, forKey: .row)
        try container.encode(column, forKey: .column)
    }
}

private enum LayoutGridCodingKey: String, CodingKey {
    case spacing
    case alignment
    case content
}

extension Layout.Grid: Codable where Scalar: Codable, Content: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutGridCodingKey.self)
        self.init(
            spacing: try container.decode(
                Layout<Scalar, Space>.Grid<Content>.Gaps.self,
                forKey: .spacing
            ),
            alignment: try container.decode(Alignment.self, forKey: .alignment),
            content: try container.decode(Content.self, forKey: .content)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutGridCodingKey.self)
        try container.encode(spacing, forKey: .spacing)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(content, forKey: .content)
    }
}

private enum LayoutGridLazyCodingKey: String, CodingKey {
    case columns
    case spacing
    case content
}

extension Layout.Grid.Lazy: Codable where Scalar: Codable, Content: Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: LayoutGridLazyCodingKey.self)
        self.init(
            columns: try container.decode(Columns.self, forKey: .columns),
            spacing: try container.decode(
                Layout<Scalar, Space>.Grid<Content>.Gaps.self,
                forKey: .spacing
            ),
            content: try container.decode(Content.self, forKey: .content)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: LayoutGridLazyCodingKey.self)
        try container.encode(columns, forKey: .columns)
        try container.encode(spacing, forKey: .spacing)
        try container.encode(content, forKey: .content)
    }
}
