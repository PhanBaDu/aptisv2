import SwiftUI

struct SentenceOrderPartView: View {
    let partNumber: Int
    let exercise: SentenceOrderExercise
    let onPass: () -> Void

    @State private var answerOrder: [Int] = []
    @State private var checkState: AnswerCheckState = .idle

    private var availableSentences: [IndexedSentence] {
        exercise.sentences.enumerated()
            .filter { !answerOrder.contains($0.offset) }
            .map { IndexedSentence(index: $0.offset, text: $0.element) }
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ReadingPartHeader(
                        part: "Part \(partNumber)",
                        instruction: exercise.instruction
                    )

                    Text(exercise.topicTitle)
                        .font(.headline)

                    promptSection
                    answerSection
                    choicesSection
                }
                .padding()
                .padding(.bottom, 16)
            }

            AnswerActionBar(
                checkState: checkState,
                isCheckEnabled: answerOrder.count == exercise.sentences.count,
                onCheck: checkAnswer,
                onPass: onPass,
                onRetry: resetAnswers
            )
        }
    }

    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Đề")

            ReadingGlassRow(tint: .blue.opacity(0.35), interactive: false) {
                HStack(alignment: .top, spacing: 10) {
                    Text("0.")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    Text(exercise.openingSentence)
                        .font(.body)
                }
            }
        }
    }

    private var answerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Khu vực đáp án")

            if answerOrder.isEmpty {
                Text("Chọn câu bên dưới theo thứ tự đúng. Câu chọn đầu tiên sẽ ở vị trí số 1.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 4)
            }

            GlassEffectContainer(spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(Array(answerOrder.enumerated()), id: \.offset) { position, sentenceIndex in
                        answerRow(
                            position: position + 1,
                            text: exercise.sentences[sentenceIndex],
                            sentenceIndex: sentenceIndex,
                            isCorrect: checkState == .idle || exercise.correctOrder[position] == sentenceIndex
                        )
                    }

                    ForEach(answerOrder.count..<exercise.sentences.count, id: \.self) { slot in
                        emptySlot(number: slot + 1)
                    }
                }
            }
        }
    }

    private var choicesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Khu vực chọn đáp án")

            if availableSentences.isEmpty {
                Text("Đã chọn hết các câu.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            GlassEffectContainer(spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(availableSentences) { item in
                        Button {
                            guard checkState == .idle else { return }
                            answerOrder.append(item.index)
                        } label: {
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "plus.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .padding(.top, 2)
                                Text(item.text)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .glassEffect(
                                LiquidGlass.glass(interactive: true),
                                in: LiquidGlass.rowShape
                            )
                        }
                        .buttonStyle(.plain)
                        .disabled(checkState != .idle)
                    }
                }
            }
        }
    }

    private func answerRow(position: Int, text: String, sentenceIndex: Int, isCorrect: Bool) -> some View {
        Button {
            guard checkState == .idle else { return }
            answerOrder.removeAll { $0 == sentenceIndex }
        } label: {
            HStack(alignment: .top, spacing: 10) {
                Text("\(position).")
                    .font(.subheadline.bold())
                    .foregroundStyle(positionColor(isCorrect: isCorrect))
                Text(text)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0)
                if checkState == .idle {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(
                LiquidGlass.glass(
                    AnswerFeedbackTint.forCheckState(checkState, isCorrect: isCorrect),
                    interactive: checkState == .idle
                ),
                in: LiquidGlass.rowShape
            )
        }
        .buttonStyle(.plain)
    }

    private func emptySlot(number: Int) -> some View {
        HStack(spacing: 10) {
            Text("\(number).")
                .font(.subheadline.bold())
                .foregroundStyle(.tertiary)
            Text("—")
                .foregroundStyle(.tertiary)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.clear, in: LiquidGlass.rowShape)
    }

    private func positionColor(isCorrect: Bool) -> Color {
        switch checkState {
        case .idle: return .primary
        case .correct: return .green
        case .incorrect: return isCorrect ? .green : .red
        }
    }

    private func checkAnswer() {
        checkState = answerOrder == exercise.correctOrder ? .correct : .incorrect
    }

    private func resetAnswers() {
        answerOrder = []
        checkState = .idle
    }
}

private struct IndexedSentence: Identifiable {
    let index: Int
    let text: String

    var id: Int { index }
}
