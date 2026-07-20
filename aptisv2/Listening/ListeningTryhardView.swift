import SwiftUI

private struct ListeningTryhardQuestion: Identifiable {
    let examID: String
    let examTitle: String
    let question: ListeningMultipleChoiceQuestion

    var id: String {
        "\(examID)-\(question.id)"
    }
}

struct ListeningTryhardView: View {
    private let allQuestions: [ListeningTryhardQuestion]

    @State private var questions: [ListeningTryhardQuestion]
    @State private var selections: [String: String] = [:]
    @State private var reviewQuestions: [ListeningTryhardQuestion] = []
    @State private var isReviewing = false

    init() {
        let allQuestions = ListeningExamStore.exams.flatMap { exam in
            exam.mc.map {
                ListeningTryhardQuestion(
                    examID: exam.id,
                    examTitle: exam.title,
                    question: $0
                )
            }
        }
        self.allQuestions = allQuestions
        _questions = State(initialValue: allQuestions.shuffled())
    }

    private var visibleQuestions: [ListeningTryhardQuestion] {
        isReviewing ? reviewQuestions : questions
    }

    private var answeredCount: Int {
        questions.reduce(into: 0) { result, item in
            if selections[item.id] != nil {
                result += 1
            }
        }
    }

    private var isComplete: Bool {
        answeredCount == questions.count
    }

    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 14) {
                        header
                            .id("tryhard-top")

                        if isReviewing && reviewQuestions.isEmpty {
                            perfectResult
                        } else {
                            ForEach(Array(visibleQuestions.enumerated()), id: \.element.id) { index, item in
                                questionCard(item, displayIndex: index + 1)
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
            }
            .safeAreaInset(edge: .bottom) {
                actionBar(proxy: proxy)
            }
        }
        .navigationTitle("Listening Tryhard")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(
                isReviewing ? "Review câu sai" : "Listening Tryhard",
                systemImage: isReviewing ? "xmark.circle.fill" : "bolt.fill"
            )
            .font(.title2.bold())
            .foregroundStyle(isReviewing ? .red : .purple)

            if isReviewing {
                Text("Chỉ còn \(reviewQuestions.count) câu trả lời sai. Lựa chọn của bạn được đánh dấu đỏ và đáp án đúng được đánh dấu xanh.")
                    .foregroundStyle(.secondary)
            } else {
                Text("Tổng hợp Q1–Q13 và Q16–Q17 từ 12 bộ Listening. Không bao gồm Q14 và Q15; thứ tự câu hỏi được trộn ngẫu nhiên.")
                    .foregroundStyle(.secondary)

                Label(
                    "\(answeredCount)/\(questions.count) đã trả lời",
                    systemImage: "checklist"
                )
                .font(.subheadline.bold())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        }
    }

    private func questionCard(
        _ item: ListeningTryhardQuestion,
        displayIndex: Int
    ) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(alignment: .firstTextBaseline) {
                Text("Câu \(displayIndex)")
                    .font(.headline)
                    .foregroundStyle(.purple)

                Spacer()

                Text("\(item.examTitle) · Q\(item.question.id)")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
            }

            Text(item.question.question)
                .font(.body.weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 9) {
                ForEach(Array(item.question.options.enumerated()), id: \.offset) { index, option in
                    optionButton(
                        item: item,
                        option: option,
                        letter: String(UnicodeScalar(65 + index)!)
                    )
                }
            }

            if isReviewing {
                Label(
                    "Đáp án đúng: \(answerLetter(for: item.question)). \(item.question.answer)",
                    systemImage: "lightbulb.fill"
                )
                .font(.subheadline.bold())
                .foregroundStyle(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        }
    }

    private func optionButton(
        item: ListeningTryhardQuestion,
        option: String,
        letter: String
    ) -> some View {
        let selected = selections[item.id] == option
        let isCorrectAnswer = option == item.question.answer
        let tint: Color = {
            if isReviewing && isCorrectAnswer { return .green }
            if isReviewing && selected { return .red }
            if selected { return .purple }
            return .secondary
        }()

        return Button {
            guard !isReviewing else { return }
            selections[item.id] = option
        } label: {
            HStack(spacing: 12) {
                Text(letter)
                    .font(.subheadline.bold())
                    .frame(width: 30, height: 30)
                    .background(tint.opacity(0.15), in: Circle())
                    .foregroundStyle(tint)

                Text(option)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 0)

                if isReviewing && isCorrectAnswer {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                } else if isReviewing && selected {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                } else if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.purple)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(tint.opacity(selected || (isReviewing && isCorrectAnswer) ? 0.10 : 0.04), in: RoundedRectangle(cornerRadius: 13))
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .strokeBorder(tint.opacity(selected || (isReviewing && isCorrectAnswer) ? 0.5 : 0.12), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }

    private var perfectResult: some View {
        VStack(spacing: 14) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 56))
                .foregroundStyle(.green)

            Text("Không có câu sai!")
                .font(.title2.bold())

            Text("Bạn đã trả lời đúng toàn bộ \(questions.count) câu.")
                .foregroundStyle(.secondary)
        }
        .padding(28)
        .frame(maxWidth: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 20))
    }

    private func actionBar(proxy: ScrollViewProxy) -> some View {
        VStack(spacing: 7) {
            if !isReviewing && !isComplete {
                Text("Còn \(questions.count - answeredCount) câu chưa trả lời")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Button {
                if isReviewing {
                    if reviewQuestions.isEmpty {
                        restartAll()
                    } else {
                        continueWrongQuestions()
                    }
                } else {
                    reviewQuestions = questions.filter {
                        selections[$0.id] != $0.question.answer
                    }
                    withAnimation {
                        isReviewing = true
                    }
                    proxy.scrollTo("tryhard-top", anchor: .top)
                }
            } label: {
                Label(
                    reviewActionTitle,
                    systemImage: isReviewing ? "arrow.right.circle.fill" : "checkmark.circle.fill"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background((isReviewing ? Color.purple : Color.blue).opacity(0.17), in: Capsule())
                .foregroundStyle(isReviewing ? .purple : .blue)
            }
            .buttonStyle(.plain)
            .disabled(!isReviewing && !isComplete)
            .opacity(isReviewing || isComplete ? 1 : 0.45)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }

    private var reviewActionTitle: String {
        guard isReviewing else { return "Kiểm tra" }
        return reviewQuestions.isEmpty
            ? "Làm lại toàn bộ"
            : "Làm tiếp \(reviewQuestions.count) câu sai"
    }

    private func continueWrongQuestions() {
        questions = reviewQuestions.shuffled()
        for question in questions {
            selections.removeValue(forKey: question.id)
        }
        reviewQuestions.removeAll()
        withAnimation {
            isReviewing = false
        }
    }

    private func restartAll() {
        questions = allQuestions.shuffled()
        selections.removeAll()
        reviewQuestions.removeAll()
        withAnimation {
            isReviewing = false
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
}
