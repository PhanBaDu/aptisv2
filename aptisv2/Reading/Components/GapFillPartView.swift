import SwiftUI

struct GapFillPartView: View {
    let exercise: GapFillExercise
    let onPass: () -> Void

    @State private var selections: [Int: String] = [:]
    @State private var checkState: AnswerCheckState = .idle
    @State private var resetToken = 0

    private var gaps: [GapFillItem] { exercise.gaps }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ReadingPartHeader(
                    part: "Part 1",
                    instruction: exercise.instruction
                )

                emailCard
            }
            .padding()
            .padding(.bottom, 16)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            AnswerActionBar(
                checkState: checkState,
                isCheckEnabled: selections.count == gaps.count,
                onCheck: checkAnswer,
                onPass: onPass,
                onRetry: resetAnswers
            )
        }
    }

    private var emailCard: some View {
        ReadingContentCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(exercise.prefix)

                gapRow(suffix: exercise.suffixAfterGap1, gapID: 1)
                gapRow(suffix: exercise.suffixAfterGap2, gapID: 2)
                gapRow(suffix: exercise.suffixAfterGap3, gapID: 3)
                gapRow(suffix: exercise.suffixAfterGap4, gapID: 4)
                gapRow(suffix: exercise.suffixAfterGap5, gapID: 5)
            }
            .font(.body)
            .lineSpacing(4)
        }
    }

    @ViewBuilder
    private func gapRow(suffix: String, gapID: Int) -> some View {
        FlowTextRow {
            if let gap = gaps.first(where: { $0.id == gapID }) {
                GapChip(
                    gap: gap,
                    selection: binding(for: gapID),
                    checkState: checkState,
                    isCorrect: gap.correctAnswer == selections[gapID]
                )
            }
            Text(suffix)
        }
    }

    private func binding(for gapID: Int) -> Binding<String?> {
        Binding(
            get: { selections[gapID] },
            set: { selections[gapID] = $0 }
        )
    }

    private func checkAnswer() {
        let allCorrect = gaps.allSatisfy { selections[$0.id] == $0.correctAnswer }
        checkState = allCorrect ? .correct : .incorrect
    }

    private func resetAnswers() {
        selections = [:]
        checkState = .idle
        resetToken += 1
    }
}

private struct FlowTextRow<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .center, spacing: 4, content: content)
            VStack(alignment: .leading, spacing: 4, content: content)
        }
    }
}

private struct GapChip: View {
    let gap: GapFillItem
    @Binding var selection: String?
    let checkState: AnswerCheckState
    let isCorrect: Bool

    var body: some View {
        Menu {
            ForEach(gap.options, id: \.self) { option in
                Button {
                    selection = option
                } label: {
                    Text(option)
                    if selection == option {
                        Image(systemName: "checkmark")
                    }
                }
            }
        } label: {
            Text(selection ?? "______")
                .font(.body.bold())
                .foregroundStyle(chipForeground)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .frame(minWidth: 56, minHeight: 44)
                .contentShape(Capsule())
                .background(chipBackground, in: Capsule())
        }
        .disabled(checkState != .idle)
    }

    private var chipBackground: Color {
        if let tint = AnswerFeedbackTint.forCheckState(checkState, isCorrect: isCorrect) {
            return tint.opacity(0.2)
        }
        return Color.gray.opacity(0.1)
    }

    private var chipForeground: Color {
        switch checkState {
        case .idle:
            return selection == nil ? .secondary : .primary
        case .correct:
            return .primary
        case .incorrect:
            return isCorrect ? .green : .red
        }
    }
}
