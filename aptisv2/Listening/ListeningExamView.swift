import SwiftUI

struct ListeningExamView: View {
    let exam: ListeningExam

    @State private var selections: [String: String] = [:]
    @State private var hasChecked = false
    @State private var q15FirstSpeaker: ListeningFirstSpeaker

    init(exam: ListeningExam) {
        self.exam = exam
        _q15FirstSpeaker = State(initialValue: exam.q15.firstSpeaker)
    }

    private var answeredCount: Int {
        selections.values.filter { !$0.isEmpty }.count
    }

    private var isComplete: Bool {
        answeredCount == exam.answerCount
    }

    private var correctCount: Int {
        guard hasChecked else { return 0 }

        let multipleChoiceCorrect = exam.mc.reduce(into: 0) { result, question in
            if selections[mcKey(question.id)] == question.answer {
                result += 1
            }
        }
        let speakerCorrect = exam.q14.speakers.reduce(into: 0) { result, speaker in
            if selections[speakerKey(speaker)] == exam.q14.answers[speaker] {
                result += 1
            }
        }
        let opinionCorrect = exam.q15.answers.indices.reduce(into: 0) { result, index in
            if selections[opinionKey(index)] == q15Answer(at: index) {
                result += 1
            }
        }
        return multipleChoiceCorrect + speakerCorrect + opinionCorrect
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    header
                        .id("top")

                    ForEach(exam.mc.prefix(13)) { question in
                        multipleChoiceCard(question)
                    }

                    speakerCard
                    opinionCard

                    ForEach(exam.mc.dropFirst(13)) { question in
                        multipleChoiceCard(question)
                    }

                    if hasChecked {
                        reviewSummary
                    }
                }
                .padding()
                .padding(.bottom, 76)
            }
            .background(Color.gray.opacity(0.16).ignoresSafeArea())
            .safeAreaInset(edge: .bottom) {
                actionBar(proxy: proxy)
            }
        }
        .navigationTitle(exam.title)
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bài thi Listening")
                .font(.title2.bold())

            Text("Chọn đáp án cho toàn bộ câu hỏi, sau đó nhấn “Kiểm tra”. Các câu đúng và sai sẽ được đánh dấu để bạn xem lại.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Label("\(answeredCount)/\(exam.answerCount) đã trả lời", systemImage: "checklist")
                Spacer()
                if hasChecked {
                    Text("\(correctCount)/\(exam.answerCount) đúng")
                        .fontWeight(.semibold)
                        .foregroundStyle(scoreColor)
                }
            }
            .font(.subheadline)
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func multipleChoiceCard(
        _ question: ListeningMultipleChoiceQuestion
    ) -> some View {
        let key = mcKey(question.id)

        return questionCard(
            title: "Q\(question.id)",
            question: question.question,
            key: key,
            options: question.options,
            answer: question.answer
        )
    }

    private var speakerCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            questionHeading(
                title: "Q14",
                question: "Four people are talking about \(exam.q14.topic). Match each speaker with the correct option."
            )

            optionsReference(exam.q14.options)

            ForEach(exam.q14.speakers, id: \.self) { speaker in
                selectionMenu(
                    label: "Speaker \(speaker)",
                    key: speakerKey(speaker),
                    options: exam.q14.options,
                    answer: exam.q14.answers[speaker] ?? ""
                )
            }
        }
        .listeningCard()
    }

    private var opinionCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Q15")
                .font(.headline)
                .foregroundStyle(.blue)

            q15TopicBanner

            Text("Chọn thứ tự người nói đúng với file nghe. Đáp án Man/Woman sẽ tự động đảo khi bạn đổi lựa chọn.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Picker("Thứ tự người nói", selection: $q15FirstSpeaker) {
                ForEach(ListeningFirstSpeaker.allCases) { speaker in
                    Text(speaker.title).tag(speaker)
                }
            }
            .pickerStyle(.segmented)
            .disabled(hasChecked)

            ForEach(exam.q15.statements.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 8) {
                    Text(exam.q15.statements[index])
                        .font(.body)

                    selectionMenu(
                        label: "Chọn ý kiến",
                        key: opinionKey(index),
                        options: ["Man", "Woman", "Both"],
                        answer: q15Answer(at: index)
                    )
                }
                .padding(.vertical, 4)

                if index < exam.q15.statements.count - 1 {
                    Divider()
                }
            }
        }
        .listeningCard()
    }

    private var q15TopicBanner: some View {
        VStack(alignment: .leading, spacing: 7) {
            Label("CHỦ ĐỀ", systemImage: "highlighter")
                .font(.caption.bold())
                .foregroundStyle(.orange)

            Text(exam.q15.topic)
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text(exam.q15.topicVietnamese)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.orange)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color.orange.opacity(0.35), lineWidth: 1)
        }
    }

    private func questionCard(
        title: String,
        question: String,
        key: String,
        options: [String],
        answer: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            questionHeading(title: title, question: question)

            VStack(spacing: 9) {
                ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                    optionButton(
                        letter: String(UnicodeScalar(65 + index)!),
                        option: option,
                        key: key,
                        answer: answer
                    )
                }
            }

            feedback(key: key, answer: answer)
        }
        .listeningCard()
    }

    private func questionHeading(title: String, question: String) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.blue)

            Text(question)
                .font(.body.weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func optionButton(
        letter: String,
        option: String,
        key: String,
        answer: String
    ) -> some View {
        let selected = selections[key] == option
        let state = optionState(option: option, key: key, answer: answer)

        return Button {
            guard !hasChecked else { return }
            selections[key] = option
        } label: {
            HStack(spacing: 12) {
                Text(letter)
                    .font(.subheadline.bold())
                    .frame(width: 30, height: 30)
                    .background(state.tint.opacity(0.16), in: Circle())
                    .foregroundStyle(state.tint)

                Text(option)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 0)

                if let icon = state.icon {
                    Image(systemName: icon)
                        .foregroundStyle(state.tint)
                } else if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(state.background, in: RoundedRectangle(cornerRadius: 13, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .strokeBorder(state.border, lineWidth: selected || state.icon != nil ? 1.5 : 1)
            }
        }
        .buttonStyle(.plain)
    }

    private func selectionMenu(
        label: String,
        key: String,
        options: [String],
        answer: String
    ) -> some View {
        let selection = selections[key]
        let isCorrect = selection == answer

        return VStack(alignment: .leading, spacing: 7) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        selections[key] = option
                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Text(label)
                        .fontWeight(.semibold)

                    Spacer()

                    Text(selection ?? "Chọn đáp án")
                        .foregroundStyle(selection == nil ? .secondary : .primary)
                        .multilineTextAlignment(.trailing)

                    Image(systemName: menuIcon(selection: selection, answer: answer))
                        .foregroundStyle(menuTint(selection: selection, answer: answer))
                }
                .padding(12)
                .background(menuBackground(selection: selection, answer: answer), in: RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .disabled(hasChecked)

            if hasChecked && !isCorrect {
                Label("Đáp án đúng: \(answer)", systemImage: "lightbulb.fill")
                    .font(.caption)
                    .foregroundStyle(.green)
            }
        }
    }

    private func optionsReference(_ options: [String]) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("LIST OF OPTIONS")
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                Text("\(romanNumeral(index + 1)). \(option)")
                    .font(.subheadline)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
    }

    @ViewBuilder
    private func feedback(key: String, answer: String) -> some View {
        if hasChecked, selections[key] != answer {
            Label("Đáp án đúng: \(answer)", systemImage: "lightbulb.fill")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.green)
        }
    }

    private var reviewSummary: some View {
        VStack(spacing: 10) {
            Image(systemName: correctCount == exam.answerCount ? "checkmark.seal.fill" : "chart.bar.fill")
                .font(.system(size: 38))
                .foregroundStyle(scoreColor)

            Text(correctCount == exam.answerCount ? "Hoàn thành xuất sắc!" : "Kết quả bài làm")
                .font(.title3.bold())

            Text("Bạn trả lời đúng \(correctCount) trên \(exam.answerCount) câu.")
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func actionBar(proxy: ScrollViewProxy) -> some View {
        VStack(spacing: 8) {
            if !isComplete && !hasChecked {
                Text("Hãy trả lời thêm \(exam.answerCount - answeredCount) câu")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Button {
                if hasChecked {
                    selections.removeAll()
                    hasChecked = false
                } else {
                    withAnimation {
                        hasChecked = true
                    }
                    proxy.scrollTo("top", anchor: .top)
                }
            } label: {
                Label(
                    hasChecked ? "Làm lại" : "Kiểm tra",
                    systemImage: hasChecked ? "arrow.counterclockwise" : "checkmark.circle.fill"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(hasChecked ? Color.orange.opacity(0.18) : Color.blue.opacity(0.16), in: Capsule())
                .foregroundStyle(hasChecked ? .orange : .blue)
            }
            .buttonStyle(.plain)
            .disabled(!isComplete && !hasChecked)
            .opacity(isComplete || hasChecked ? 1 : 0.45)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }

    private var scoreColor: Color {
        let ratio = Double(correctCount) / Double(max(exam.answerCount, 1))
        if ratio >= 0.8 { return .green }
        if ratio >= 0.5 { return .orange }
        return .red
    }

    private func mcKey(_ id: String) -> String { "mc-\(id)" }
    private func speakerKey(_ speaker: String) -> String { "q14-\(speaker)" }
    private func opinionKey(_ index: Int) -> String { "q15-\(index)" }

    private func q15Answer(at index: Int) -> String {
        let original = exam.q15.answers[index]
        guard q15FirstSpeaker != exam.q15.firstSpeaker else {
            return original
        }

        switch original {
        case "Man": return "Woman"
        case "Woman": return "Man"
        default: return original
        }
    }

    private func romanNumeral(_ value: Int) -> String {
        ["i", "ii", "iii", "iv", "v", "vi"][value - 1]
    }

    private func menuIcon(selection: String?, answer: String) -> String {
        guard hasChecked else { return "chevron.up.chevron.down" }
        return selection == answer ? "checkmark.circle.fill" : "xmark.circle.fill"
    }

    private func menuTint(selection: String?, answer: String) -> Color {
        guard hasChecked else { return .secondary }
        return selection == answer ? .green : .red
    }

    private func menuBackground(selection: String?, answer: String) -> Color {
        guard hasChecked else { return Color.gray.opacity(0.08) }
        return (selection == answer ? Color.green : Color.red).opacity(0.11)
    }

    private func optionState(
        option: String,
        key: String,
        answer: String
    ) -> ListeningOptionVisualState {
        let selected = selections[key] == option

        guard hasChecked else {
            return ListeningOptionVisualState(
                tint: selected ? .blue : .secondary,
                background: selected ? Color.blue.opacity(0.10) : Color.gray.opacity(0.06),
                border: selected ? Color.blue.opacity(0.55) : Color.gray.opacity(0.14),
                icon: nil
            )
        }

        if option == answer {
            return ListeningOptionVisualState(
                tint: .green,
                background: Color.green.opacity(0.11),
                border: Color.green.opacity(0.55),
                icon: "checkmark.circle.fill"
            )
        }

        if selected {
            return ListeningOptionVisualState(
                tint: .red,
                background: Color.red.opacity(0.10),
                border: Color.red.opacity(0.55),
                icon: "xmark.circle.fill"
            )
        }

        return ListeningOptionVisualState(
            tint: .secondary,
            background: Color.gray.opacity(0.04),
            border: Color.gray.opacity(0.12),
            icon: nil
        )
    }
}

private struct ListeningOptionVisualState {
    let tint: Color
    let background: Color
    let border: Color
    let icon: String?
}

private extension View {
    func listeningCard() -> some View {
        padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.gray.opacity(0.12), lineWidth: 1)
            }
    }
}
