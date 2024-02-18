import SwiftUI

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(menu: MenuType = .slided,
                                            status: Binding<SwipeState> = .constant(.untouched),
                                            allowReordering: Binding<Bool> = .constant(false),
                                            @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) -> some View {
        self.modifier(SwipeAction.init(menu: menu,
                                       status: status,
                                       allowReordering: allowReordering,
                                       content))
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(menu: MenuType = .slided,
                                  edge: HorizontalAlignment,
                                  status: Binding<SwipeState> = .constant(.untouched),
                                  allowReordering: Binding<Bool> = .constant(false),
                                  @ViewBuilder _ content: @escaping () -> V1) -> some View {
        switch edge {
        case .leading:
            self.modifier(SwipeAction<V1, EmptyView>.init(menu: menu,
                                                          status: status,
                                                          allowReordering: allowReordering,
                                                          leading: content))
        default:
            self.modifier(SwipeAction<EmptyView, V1>.init(menu: menu,
                                                          status: status,
                                                          allowReordering: .constant(false),
                                                          trailing: content))
        }
    }

    @ViewBuilder
    func addFullSwipeAction<V1: View, V2: View>(menu: MenuType = .slided,
                                                swipeColor: Color = Color.red,
                                                swipeRole: SwipeRole = .destructive,
                                                status: Binding<SwipeState> = .constant(.untouched),
                                                allowReordering: Binding<Bool> = .constant(false),
                                                @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>,
                                                action: (() -> Void)? = nil) -> some View {
        self.modifier(SwipeAction.init(menu: menu,
                                       allowsFullSwipe: true,
                                       fullSwipeRole: swipeRole,
                                       swipeColor: swipeColor,
                                       status: status,
                                       allowReordering: allowReordering,
                                       content,
                                       action: action))
    }
}
