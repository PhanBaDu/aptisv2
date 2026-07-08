import SwiftUI

struct HeadingMatchingPartView: View {
    let exercise: HeadingMatchingExercise
    let onPass: () -> Void

    @State private var answerOrder: [String] = []
    @State private var checkState: AnswerCheckState = .idle

    private var headings: [HeadingOption] { exercise.headings }
    private var correctOrder: [String] { exercise.correctOrder }

    private var availableHeadings: [HeadingOption] {
        headings.filter { !answerOrder.contains($0.id) }
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ReadingPartHeader(
                        part: "Part 5",
                        instruction: exercise.instruction
                    )

                    Text(exercise.passageTitle)
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
                isCheckEnabled: answerOrder.count == correctOrder.count,
                onCheck: checkAnswer,
                onPass: onPass,
                onRetry: resetAnswers
            )
        }
    }

    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Đề")

            VStack(spacing: 10) {
                VStack(spacing: 10) {
                    ReadingGlassRow(tint: .blue.opacity(0.35), interactive: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("0. \(exercise.openingHeading)")
                                .font(.headline.bold())
                            Text(exercise.openingParagraph)
                                .font(.body)
                        }
                        .foregroundStyle(.secondary)
                        .lineSpacing(3)
                    }

                    ForEach(Array(exercise.paragraphs.enumerated()), id: \.offset) { index, paragraph in
                        ReadingGlassRow(interactive: false) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(index + 1).")
                                    .font(.subheadline.bold())
                                Text(paragraph)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineSpacing(3)
                            }
                        }
                    }
                }
            }
        }
    }

    private var answerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Khu vực đáp án")

            if answerOrder.isEmpty {
                Text("Chọn heading theo thứ tự đoạn 1–7. Heading chọn đầu tiên sẽ gán cho đoạn 1.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(Array(answerOrder.enumerated()), id: \.offset) { position, headingID in
                        if let heading = headings.first(where: { $0.id == headingID }) {
                            answerRow(
                                position: position + 1,
                                heading: heading,
                                isCorrect: checkState == .idle || correctOrder[position] == headingID
                            )
                        }
                    }

                    ForEach(answerOrder.count..<correctOrder.count, id: \.self) { slot in
                        emptySlot(number: slot + 1)
                    }
                }
            }
        }
    }

    private var choicesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReadingSectionLabel(title: "Khu vực chọn đáp án")

            VStack(spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(availableHeadings) { heading in
                        Button {
                            guard checkState == .idle else { return }
                            answerOrder.append(heading.id)
                        } label: {
                            HStack(alignment: .top, spacing: 10) {
                                Text(heading.label)
                                    .font(.subheadline.bold())
                                    .frame(width: 20)
                                Text(heading.text)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
                                Image(systemName: "plus.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                        .disabled(checkState != .idle)
                    }
                }
            }
        }
    }

    private func answerRow(position: Int, heading: HeadingOption, isCorrect: Bool) -> some View {
        Button {
            guard checkState == .idle else { return }
            answerOrder.removeAll { $0 == heading.id }
        } label: {
            HStack(alignment: .top, spacing: 10) {
                Text("\(position).")
                    .font(.subheadline.bold())
                    .foregroundStyle(positionColor(isCorrect: isCorrect))
                Text("\(heading.label). \(heading.text)")
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
            .background(AnswerFeedbackTint.forCheckState(checkState, isCorrect: isCorrect)?.opacity(0.1) ?? .white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(AnswerFeedbackTint.forCheckState(checkState, isCorrect: isCorrect) ?? .gray.opacity(0.12), lineWidth: 1)
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
        .background(Color.gray.opacity(0.05), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 1, dash: [4]))
        )
    }

    private func positionColor(isCorrect: Bool) -> Color {
        switch checkState {
        case .idle: return .primary
        case .correct: return .green
        case .incorrect: return isCorrect ? .green : .red
        }
    }

    private func checkAnswer() {
        checkState = answerOrder == correctOrder ? .correct : .incorrect
    }

    private func resetAnswers() {
        answerOrder = []
        checkState = .idle
    }
}
