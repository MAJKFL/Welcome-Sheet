// Source: https://stackoverflow.com/a/66875954

import SwiftUI

struct OverflowScrollView<Content>: View where Content : View {
    
    @State private var axes: Axis.Set
    
    private let showsIndicator: Bool
    
    private let content: Content
    
    init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self._axes = .init(wrappedValue: axes)
        self.showsIndicator = showsIndicators
        self.content = content()
    }

    fileprivate init(scrollView: ScrollView<Content>) {
        self._axes = .init(wrappedValue: scrollView.axes)
        self.showsIndicator = scrollView.showsIndicators
        self.content = scrollView.content
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView(axes, showsIndicators: showsIndicator) {
                content
                    .background(ContentSizeReader())
                    .onPreferenceChange(ContentSizeKey.self) {
                        if $0.height <= geometry.size.height {
                            axes.remove(.vertical)
                        }
                        if $0.width <= geometry.size.width {
                            axes.remove(.horizontal)
                        }
                    }
            }
        }
    }
}

private struct ContentSizeReader: View {
    
    var body: some View {
        GeometryReader {
            Color.clear
                .preference(
                    key: ContentSizeKey.self,
                    value: $0.frame(in: .local).size
                )
        }
    }
}

private struct ContentSizeKey: PreferenceKey {
    static var defaultValue: CGSize { .zero }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = CGSize(width: value.width+nextValue().width,
                       height: value.height+nextValue().height)
    }
}

extension ScrollView {
    func scrollOnlyOnOverflow() -> some View {
        OverflowScrollView(scrollView: self)
    }
}
