import SwiftUI

extension View {
    /// Ẩn tab bar — chỉ hiện ở 5 tab gốc (Listening, Reading, Writing, Speaking, Answers).
    func hidesTabBarWhenPushed() -> some View {
        toolbar(.hidden, for: .tabBar)
    }
}
