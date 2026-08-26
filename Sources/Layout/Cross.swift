public enum Cross {}

extension Cross {

    public enum Alignment: Sendable, Hashable, Codable, CaseIterable {

        case leading

        case center

        case trailing

        case fill
    }
}
