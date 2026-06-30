import SwiftUI

private struct GapAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]

    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct GapFillPartView: View {
    let exercise: GapFillExercise
    let onPass: () -> Void

    @State private var selections: [Int: String] = [:]
    @State private var checkState: AnswerCheckState = .idle
    @State private var resetToken = 0
    @State private var presentedGapID: Int?

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
        .overlayPreferenceValue(GapAnchorKey.self) { anchors in
            gapOptionsOverlay(anchors: anchors)
        }
        .onChange(of: resetToken) { _, _ in
            presentedGapID = nil
        }
        .onChange(of: checkState) { _, _ in
            presentedGapID = nil
        }
    }

    @ViewBuilder
    private func gapOptionsOverlay(anchors: [Int: Anchor<CGRect>]) -> some View {
        if let gapID = presentedGapID,
           let gap = gaps.first(where: { $0.id == gapID }),
           let chipAnchor = anchors[gapID] {
            GeometryReader { geometry in
                let chipFrame = geometry[chipAnchor]
                let menuWidth: CGFloat = 168
                let menuHeight = CGFloat(gap.options.count) * 50 + 24
                let x = min(
                    max(chipFrame.midX, menuWidth / 2 + 16),
                    geometry.size.width - menuWidth / 2 - 16
                )
                let y = chipFrame.maxY + menuHeight / 2 + 12

                ZStack {
                    Color.black.opacity(0.08)
                        .ignoresSafeArea()
                        .onTapGesture { presentedGapID = nil }

                    GapOptionsPopover(
                        gap: gap,
                        selection: selections[gapID],
                        onSelect: { word in
                            selections[gapID] = word
                            presentedGapID = nil
                        }
                    )
                    .frame(width: menuWidth)
                    .position(x: x, y: y)
                    .shadow(color: .black.opacity(0.12), radius: 16, y: 8)
                }
            }
            .ignoresSafeArea()
            .zIndex(1000)
            .transition(.opacity.combined(with: .scale(scale: 0.96, anchor: .top)))
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
                    isCorrect: gap.correctAnswer == selections[gapID],
                    onPresent: { presentedGapID = gapID }
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
        presentedGapID = nil
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
    let onPresent: () -> Void

    var body: some View {
        chipLabel
            .anchorPreference(key: GapAnchorKey.self, value: .bounds) { anchor in
                [gap.id: anchor]
            }
            .onTapGesture {
                guard checkState == .idle else { return }
                onPresent()
            }
    }

    private var chipLabel: some View {
        Text(selection ?? "______")
            .font(.body.bold())
            .foregroundStyle(chipForeground)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(minWidth: 56, minHeight: 44)
            .contentShape(Capsule())
            .glassEffect(
                LiquidGlass.glass(chipTint, interactive: false),
                in: LiquidGlass.buttonShape
            )
    }

    private var chipTint: Color? {
        AnswerFeedbackTint.forCheckState(checkState, isCorrect: isCorrect)
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

private struct GapOptionsPopover: View {
    let gap: GapFillItem
    let selection: String?
    let onSelect: (String) -> Void

    var body: some View {
        GlassEffectContainer(spacing: 6) {
            VStack(spacing: 6) {
                ForEach(gap.options, id: \.self) { option in
                    Button {
                        onSelect(option)
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body.weight(.medium))
                            Spacer(minLength: 8)
                            if selection == option {
                                Image(systemName: "checkmark")
                                    .font(.body.weight(.semibold))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .contentShape(Capsule())
                        .glassEffect(
                            LiquidGlass.glass(
                                selection == option ? .blue : nil,
                                interactive: false
                            ),
                            in: LiquidGlass.buttonShape
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
        }
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
