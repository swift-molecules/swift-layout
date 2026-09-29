#if Boundary
import Boundary
import Layout
import Layout
import Testing

@Suite
struct `Layout Boundary Tests` {

    @Test
    func `left to right layout corners map to physical corners`() {
        #expect(Boundary.Corner(.topLeading, direction: .leftToRight) == .topLeft)
        #expect(Boundary.Corner(.topTrailing, direction: .leftToRight) == .topRight)
        #expect(Boundary.Corner(.bottomLeading, direction: .leftToRight) == .bottomLeft)
        #expect(Boundary.Corner(.bottomTrailing, direction: .leftToRight) == .bottomRight)
    }

    @Test
    func `right to left layout corners reverse horizontal mapping`() {
        #expect(Boundary.Corner(.topLeading, direction: .rightToLeft) == .topRight)
        #expect(Boundary.Corner(.topTrailing, direction: .rightToLeft) == .topLeft)
        #expect(Boundary.Corner(.bottomLeading, direction: .rightToLeft) == .bottomRight)
        #expect(Boundary.Corner(.bottomTrailing, direction: .rightToLeft) == .bottomLeft)
    }
}
#endif
