import SwiftUI
import Combine

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(of value: T, onChange: @escaping (T) -> Void) -> some View {
        self.onChange(of: value, perform: onChange)
    }
}
