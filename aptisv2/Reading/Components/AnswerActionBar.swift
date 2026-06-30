import SwiftUI

enum AnswerCheckState {
    case idle
    case correct
    case incorrect
}

struct AnswerActionBar: View {
    let checkState: AnswerCheckState
    let isCheckEnabled: Bool
    let onCheck: () -> Void
    let onPass: () -> Void
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch checkState {
                case .idle:
                    ReadingGlassButton(
                        title: "Check",
                        systemImage: nil,
                        tint: .blue,
                        isEnabled: isCheckEnabled,
                        action: onCheck
                    )

                case .correct:
                    ReadingGlassButton(
                        title: "Pass",
                        systemImage: "checkmark.circle.fill",
                        tint: .green,
                        isEnabled: true,
                        action: onPass
                    )

                case .incorrect:
                    ReadingGlassButton(
                        title: "Làm lại",
                        systemImage: "arrow.counterclockwise",
                        tint: .orange,
                        isEnabled: true,
                        action: onRetry
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
    }
}
