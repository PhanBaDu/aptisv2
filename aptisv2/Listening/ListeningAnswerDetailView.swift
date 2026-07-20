import SwiftUI

struct ListeningAnswerDetailView: View {
    let exam: ListeningExam

    private var questions1To13: ArraySlice<ListeningMultipleChoiceQuestion> {
        exam.mc.prefix(13)
    }

    private var questions16And17: ArraySlice<ListeningMultipleChoiceQuestion> {
        exam.mc.dropFirst(13)
    }

    var body: some View {
        ZStack {
            Color.gray.opacity(0.16)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    multipleChoiceSection(
                        title: "Q1–Q13",
                        questions: Array(questions1To13)
                    )

                    q14Section
                    q15Section

                    multipleChoiceSection(
                        title: "Q16–Q17",
                        questions: Array(questions16And17)
                    )
                }
                .padding()
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("\(exam.title) Answers")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }

    private func multipleChoiceSection(
        title: String,
        questions: [ListeningMultipleChoiceQuestion]
    ) -> some View {
        answerSection(title: title) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(questions.enumerated()), id: \.element.id) { index, question in
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Q\(question.id). \(question.question)")
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)

                        answerLine(
                            label: answerLetter(for: question),
                            answer: question.answer
                        )
                    }
                    .padding(.vertical, 10)

                    if index < questions.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }

    private var q14Section: some View {
        answerSection(title: "Q14 · \(exam.q14.topic)") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(exam.q14.speakers, id: \.self) { speaker in
                    answerLine(
                        label: "Speaker \(speaker)",
                        answer: exam.q14.answers[speaker] ?? ""
                    )
                }
            }
        }
    }

    private var q15Section: some View {
        answerSection(title: "Q15 · \(exam.q15.topic)") {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(exam.q15.topicVietnamese)
                        .font(.subheadline.bold())
                        .foregroundStyle(.orange)

                    Label(
                        exam.q15.firstSpeaker.title,
                        systemImage: "person.wave.2.fill"
                    )
                    .font(.caption.bold())
                    .foregroundStyle(.blue)
                }

                Divider()

                ForEach(exam.q15.statements.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(index + 1). \(exam.q15.statements[index])")
                            .font(.body)

                        answerLine(
                            label: q15ShortAnswer(exam.q15.answers[index]),
                            answer: exam.q15.answers[index]
                        )
                    }
                }

                Text("Mã đáp án: \(q15AnswerCode)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.green)
                    .padding(.top, 4)
            }
        }
    }

    private func answerSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            content()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
                }
        }
    }

    private func answerLine(label: String, answer: String) -> some View {
        HStack(alignment: .top, spacing: 9) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)

            Text("\(label).")
                .font(.body.bold())
                .foregroundStyle(.green)

            Text(answer)
                .font(.body.weight(.medium))
                .foregroundStyle(.green)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func answerLetter(
        for question: ListeningMultipleChoiceQuestion
    ) -> String {
        guard let index = question.options.firstIndex(of: question.answer) else {
            return "?"
        }
        return String(UnicodeScalar(65 + index)!)
    }

    private func q15ShortAnswer(_ answer: String) -> String {
        switch answer {
        case "Man": return "M"
        case "Woman": return "W"
        default: return "B"
        }
    }

    private var q15AnswerCode: String {
        exam.q15.answers.map(q15ShortAnswer).joined()
    }
}
