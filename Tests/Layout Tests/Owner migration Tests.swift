import Foundation
import Geometry
import Direction
import Layout
import Layout_Standard_Library_Integration
import Testing

private enum Canvas {}
private enum ContentFailure: Error { case stop }

@Suite struct `Layout owner integration` {
    @Test func `writing direction resolves logical horizontal sides`() {
        #expect(Horizontal(.leading, direction: .leftToRight) == .leftward)
        #expect(Horizontal(.trailing, direction: .leftToRight) == .rightward)
        #expect(Horizontal(.leading, direction: .rightToLeft) == .rightward)
        #expect(Horizontal(.trailing, direction: .rightToLeft) == .leftward)
        #expect(Vertical(.top) == .upward)
        #expect(Vertical(.bottom) == .downward)
    }

    @Test func `line box distributes positive leading and clamps negative leading`() {
        typealias Box = Layout<Double, Canvas>.Line.Box
        let roomy = Box(ascender: 8, descender: 2, height: 14)
        #expect(roomy.leading.underlying == 2)
        #expect(roomy.ascent.underlying == 10)
        #expect(roomy.descent.underlying == 4)
        let tight = Box(ascender: 8, descender: 2, height: 6)
        #expect(tight.leading.underlying == 0)
        #expect(tight.ascent.underlying == 8 && tight.descent.underlying == 2)
    }

    @Test func `content mapping captures a value snapshot and propagates typed failure`() {
        typealias L = Layout<Double, Canvas>
        var stack = L.Stack(axis: .horizontal, spacing: 3, alignment: .leading, content: 7)
        let mapping = stack.map
        stack.content = 9
        let mapped = mapping.content { String($0) }
        #expect(mapped.content == "7")
        #expect(mapped.spacing.value == 3 && mapped.axis == .horizontal)
        do {
            let _: L.Stack<String> = try mapping.content { (_) throws(ContentFailure) in throw .stop }
            Issue.record("Expected content failure")
        } catch {
            let typed: ContentFailure = error
            #expect(typed == .stop)
        }
    }

    @Test func `flow and grid coding preserve layout policy and signed gaps`() throws {
        typealias L = Layout<Double, Canvas>
        let flow = L.Flow(spacing: .init(item: -2, line: 4), alignment: .trailing, line: .bottom, content: [1, 2])
        #expect(try JSONDecoder().decode(L.Flow<[Int]>.self, from: JSONEncoder().encode(flow)) == flow)
        let grid = L.Grid(spacing: .init(row: 3, column: 5), alignment: .bottomLeading, content: "cell")
        #expect(try JSONDecoder().decode(L.Grid<String>.self, from: JSONEncoder().encode(grid)) == grid)
        let lazy = L.Grid<String>.Lazy(columns: .fractions([1, 2, 1]), spacing: .init(row: 2, column: 4), content: "cells")
        #expect(try JSONDecoder().decode(L.Grid<String>.Lazy.self, from: JSONEncoder().encode(lazy)) == lazy)
    }
}
