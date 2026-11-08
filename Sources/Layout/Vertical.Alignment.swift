public import Direction

extension Vertical {
    public enum Alignment: Sendable, Hashable, Codable {

        case top

        case center

        case bottom

        case baseline(Vertical.Baseline)
    }
}
