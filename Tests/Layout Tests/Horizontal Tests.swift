import Testing

@testable import Direction
@testable import Layout

@Suite
struct `Horizontal.Alignment Tests` {
    @Test(arguments: Horizontal.Alignment.allCases)
    func cases(alignment: Horizontal.Alignment) {

        #expect(Horizontal.Alignment.allCases.contains(alignment))
    }

    @Test
    func `Horizontal.Alignment CaseIterable`() {
        #expect(Horizontal.Alignment.allCases.count == 3)
        #expect(Horizontal.Alignment.allCases.contains(.leading))
        #expect(Horizontal.Alignment.allCases.contains(.center))
        #expect(Horizontal.Alignment.allCases.contains(.trailing))
    }

    @Test
    func `Horizontal.Alignment Hashable`() {
        let set: Set<Horizontal.Alignment> = [.leading, .center, .trailing, .leading]
        #expect(set.count == 3)
    }

    @Test
    func `An alignment indents a run by what it leaves of the measure, from the left`() {
        #expect(Horizontal.Alignment.leading.indent(of: 30.0, in: 100, direction: .leftToRight) == 0)
        #expect(Horizontal.Alignment.center.indent(of: 30.0, in: 100, direction: .leftToRight) == 35)
        #expect(Horizontal.Alignment.trailing.indent(of: 30.0, in: 100, direction: .leftToRight) == 70)
        #expect(Horizontal.Alignment.leading.indent(of: 30.0, in: 100, direction: .rightToLeft) == 70)
        #expect(Horizontal.Alignment.center.indent(of: 30.0, in: 100, direction: .rightToLeft) == 35)
        #expect(Horizontal.Alignment.trailing.indent(of: 30.0, in: 100, direction: .rightToLeft) == 0)
        #expect(Horizontal.Alignment.trailing.indent(of: 130.0, in: 100, direction: .leftToRight) == -30)
    }
}
