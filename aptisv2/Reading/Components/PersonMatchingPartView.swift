import SwiftUI

struct PersonMatchingPartView: View {
    let exercise: PersonMatchingExercise
    let onPass: () -> Void

    @State private var selections: [Int: String] = [:]
    @State private var checkState: AnswerCheckState = .idle
    @State private var expandedPersonID: String?

    private var questions: [PersonMatchQuestion] { exercise.questions }
    private var people: [PersonPassage] { exercise.people }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ReadingPartHeader(
                        part: "Part 4",
                        instruction: exercise.instruction
                    )

                    passagesSection
                    questionsSection
                }
                .padding()
                .padding(.bottom, 16)
            }

            AnswerActionBar(
                checkState: checkState,
                isCheckEnabled: selections.count == questions.count,
                onCheck: checkAnswer,
                onPass: onPass,
                onRetry: resetAnswers
            )
        }
    }

    private var passagesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ReadingSectionLabel(title: "Bài đọc")

            GlassEffectContainer(spacing: 10) {
                VStack(spacing: 10) {
                    ForEach(people) { person in
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { expandedPersonID == person.id },
                                set: { expandedPersonID = $0 ? person.id : nil }
                            )
                        ) {
                            Text(person.text)
                                .font(.body)
                                .lineSpacing(4)
                                .padding(.top, 4)
                        } label: {
                            Text(person.name)
                                .font(.headline)
                        }
                        .padding()
                        .glassEffect(
                            LiquidGlass.glass(interactive: true),
                            in: LiquidGlass.rowShape
                        )
                    }
                }
            }
        }
    }

    private var questionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ReadingSectionLabel(title: "Câu hỏi")

            GlassEffectContainer(spacing: 12) {
                VStack(spacing: 12) {
                    ForEach(questions) { question in
                        questionRow(question)
                    }
                }
            }
        }
    }

    private func questionRow(_ question: PersonMatchQuestion) -> some View {
        let questionCorrect = selections[question.id] == question.correctPerson

        return VStack(alignment: .leading, spacing: 10) {
            Text("\(question.id). \(question.question)")
                .font(.body.weight(.medium))

            GlassEffectContainer(spacing: 8) {
                HStack(spacing: 8) {
                    ForEach(exercise.personNames, id: \.self) { name in
                        personButton(name: name, question: question)
                    }
                }
            }
        }
        .padding()
        .glassEffect(
            LiquidGlass.glass(
                checkState == .idle ? nil : (questionCorrect ? .green : .red),
                interactive: false
            ),
            in: LiquidGlass.rowShape
        )
    }

    private func personButton(name: String, question: PersonMatchQuestion) -> some View {
        let isSelected = selections[question.id] == name
        let isCorrectAnswer = question.correctPerson == name

        return Button {
            guard checkState == .idle else { return }
            selections[question.id] = name
        } label: {
            Text(name)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .glassEffect(
                    LiquidGlass.glass(
                        buttonTint(isSelected: isSelected, isCorrectAnswer: isCorrectAnswer),
                        interactive: checkState == .idle
                    ),
                    in: LiquidGlass.buttonShape
                )
        }
        .buttonStyle(.plain)
        .disabled(checkState != .idle && !isSelected)
    }

    private func buttonTint(isSelected: Bool, isCorrectAnswer: Bool) -> Color? {
        switch checkState {
        case .idle:
            return isSelected ? .blue : nil
        case .correct:
            return isCorrectAnswer ? .green : nil
        case .incorrect:
            if isSelected && isCorrectAnswer { return .green }
            if isSelected && !isCorrectAnswer { return .red }
            if !isSelected && isCorrectAnswer { return .green.opacity(0.6) }
            return nil
        }
    }

    private func checkAnswer() {
        let allCorrect = questions.allSatisfy { selections[$0.id] == $0.correctPerson }
        checkState = allCorrect ? .correct : .incorrect
    }

    private func resetAnswers() {
        selections = [:]
        checkState = .idle
    }
}
