import Testing

@testable import Layout

@Suite
struct `Layout Tests` {
    @Test
    func `Layout is a namespace`() {

        let _: Layout<Double, TestSpace>.Type = Layout<Double, TestSpace>.self
    }

    @Test
    func `Layout provides type aliases`() {

        let _: TestLayout.Width.Type = TestLayout.Width.self
        let _: TestLayout.Height.Type = TestLayout.Height.self
        let _: TestLayout.Spacing.Type = TestLayout.Spacing.self
        let _: TestLayout.Point.Type = TestLayout.Point.self
        let _: TestLayout.Size.Type = TestLayout.Size.self
    }
}
