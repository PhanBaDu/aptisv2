import SwiftUI

private enum ReadingTryhardKind {
    case gap(GapFillExercise)
    case ordering(part: Int, exercise: SentenceOrderExercise)
    case people(PersonMatchingExercise)
    case headings(HeadingMatchingExercise)
}

private struct ReadingTryhardItem: Identifiable {
    let id: String
    let examTitle: String
    let partTitle: String
    let kind: ReadingTryhardKind

    var answerCount: Int {
        switch kind {
        case .gap(let exercise): return exercise.gaps.count
        case .ordering(_, let exercise): return exercise.correctOrder.count
        case .people(let exercise): return exercise.questions.count
        case .headings(let exercise): return exercise.correctOrder.count
        }
    }
}

struct ReadingTryhardView: View {
    private let allItems: [ReadingTryhardItem]

    @State private var items: [ReadingTryhardItem]
    @State private var selections: [String: String] = [:]
    @State private var reviewItems: [ReadingTryhardItem] = []
    @State private var activeKeys: Set<String>
    @State private var reviewKeys: Set<String> = []
    @State private var isReviewing = false

    init() {
        var generated: [ReadingTryhardItem] = []

        for examIndex in 1...5 {
            let data = ReadingExamData.forExam(examIndex)
            let examTitle = "Reading \(String(format: "%02d", examIndex))"
            generated.append(
                ReadingTryhardItem(
                    id: "reading-\(examIndex)-part-1",
                    examTitle: examTitle,
                    partTitle: "Part 1 · Gap Fill",
                    kind: .gap(data.gapFill)
                )
            )
            generated.append(
                ReadingTryhardItem(
                    id: "reading-\(examIndex)-part-2",
                    examTitle: examTitle,
                    partTitle: "Part 2 · Sentence Ordering",
                    kind: .ordering(part: 2, exercise: data.orderingPart2)
                )
            )
            generated.append(
                ReadingTryhardItem(
                    id: "reading-\(examIndex)-part-3",
                    examTitle: examTitle,
                    partTitle: "Part 3 · Sentence Ordering",
                    kind: .ordering(part: 3, exercise: data.orderingPart3)
                )
            )
            generated.append(
                ReadingTryhardItem(
                    id: "reading-\(examIndex)-part-4",
                    examTitle: examTitle,
                    partTitle: "Part 4 · Person Matching",
                    kind: .people(data.personMatching)
                )
            )
            generated.append(
                ReadingTryhardItem(
                    id: "reading-\(examIndex)-part-5",
                    examTitle: examTitle,
                    partTitle: "Part 5 · Heading Matching",
                    kind: .headings(data.headingMatching)
                )
            )
        }

        let initialKeys = Set(generated.flatMap(Self.answerPairs).map(\.key))
        self.allItems = generated
        _items = State(initialValue: generated.shuffled())
        _activeKeys = State(initialValue: initialKeys)
    }

    private var totalAnswerCount: Int {
        activeKeys.count
    }

    private var answeredCount: Int {
        activeKeys.reduce(into: 0) { result, key in
            if selections[key] != nil {
                result += 1
            }
        }
    }

    private var isComplete: Bool {
        answeredCount == totalAnswerCount
    }

    private var visibleItems: [ReadingTryhardItem] {
        isReviewing ? reviewItems : items
    }

    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        header
                            .id("reading-tryhard-top")

                        if isReviewing && reviewItems.isEmpty {
                            perfectResult
                        } else {
                            ForEach(Array(visibleItems.enumerated()), id: \.element.id) { index, item in
                                itemCard(item, displayIndex: index + 1)
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
        .navigationTitle("Reading Tryhard")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(
                isReviewing ? "Review bài sai" : "Reading Tryhard",
                systemImage: isReviewing ? "xmark.circle.fill" : "book.pages.fill"
            )
            .font(.title2.bold())
            .foregroundStyle(isReviewing ? .red : .indigo)

            if isReviewing {
                Text("Chỉ giữ lại \(reviewItems.count) bài còn câu sai. Các câu đúng trong bài cũng được ẩn để bạn tập trung review.")
                    .foregroundStyle(.secondary)
            } else {
                Text("Tổng hợp toàn bộ 5 Part của 5 bộ Reading. 25 bài được trộn ngẫu nhiên, tương ứng \(totalAnswerCount) đáp án.")
                    .foregroundStyle(.secondary)

                Label(
                    "\(answeredCount)/\(totalAnswerCount) đã trả lời",
                    systemImage: "checklist"
                )
                .font(.subheadline.bold())
            }
        }
        .tryhardCard()
    }

    @ViewBuilder
    private func itemCard(
        _ item: ReadingTryhardItem,
        displayIndex: Int
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("Bài \(displayIndex)")
                    .font(.headline)
                    .foregroundStyle(.indigo)
                Spacer()
                Text("\(item.examTitle) · \(item.partTitle)")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
            }

            switch item.kind {
            case .gap(let exercise):
                gapContent(item: item, exercise: exercise)
            case .ordering(_, let exercise):
                orderingContent(item: item, exercise: exercise)
            case .people(let exercise):
                peopleContent(item: item, exercise: exercise)
            case .headings(let exercise):
                headingContent(item: item, exercise: exercise)
            }
        }
        .tryhardCard()
    }

    private func gapContent(
        item: ReadingTryhardItem,
        exercise: GapFillExercise
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.instruction)
                .font(.subheadline.weight(.semibold))

            Text(exercise.prefix)
                .font(.subheadline)

            ForEach(exercise.gaps) { gap in
                let key = "\(item.id)-gap-\(gap.id)"
                if shouldShow(key: key, answer: gap.correctAnswer) {
                    selectionRow(
                        label: "Gap \(gap.id)",
                        key: key,
                        options: gap.options,
                        answer: gap.correctAnswer
                    )
                }
            }
        }
    }

    private func orderingContent(
        item: ReadingTryhardItem,
        exercise: SentenceOrderExercise
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.instruction)
                .font(.subheadline.weight(.semibold))

            Text(exercise.topicTitle)
                .font(.headline)

            Text("0. \(exercise.openingSentence)")
                .font(.subheadline)
                .padding(10)
                .background(Color.blue.opacity(0.09), in: RoundedRectangle(cornerRadius: 10))

            ForEach(exercise.correctOrder.indices, id: \.self) { position in
                let answerIndex = exercise.correctOrder[position]
                let answer = String(answerIndex)
                let key = "\(item.id)-order-\(position)"
                if shouldShow(key: key, answer: answer) {
                    selectionRow(
                        label: "Vị trí \(position + 1)",
                        key: key,
                        options: exercise.sentences.indices.map(String.init),
                        answer: answer,
                        optionLabel: { value in
                            guard let index = Int(value) else { return value }
                            return exercise.sentences[index]
                        }
                    )
                }
            }
        }
    }

    private func peopleContent(
        item: ReadingTryhardItem,
        exercise: PersonMatchingExercise
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.instruction)
                .font(.subheadline.weight(.semibold))

            DisclosureGroup("Bài đọc của 4 người") {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(exercise.people) { person in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(person.name).font(.headline)
                            Text(person.text).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.top, 8)
            }

            ForEach(exercise.questions) { question in
                let key = "\(item.id)-person-\(question.id)"
                if shouldShow(key: key, answer: question.correctPerson) {
                    selectionRow(
                        label: question.question,
                        key: key,
                        options: exercise.personNames,
                        answer: question.correctPerson
                    )
                }
            }
        }
    }

    private func headingContent(
        item: ReadingTryhardItem,
        exercise: HeadingMatchingExercise
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.instruction)
                .font(.subheadline.weight(.semibold))

            Text(exercise.passageTitle)
                .font(.headline)

            ForEach(exercise.correctOrder.indices, id: \.self) { index in
                let answer = exercise.correctOrder[index]
                let key = "\(item.id)-heading-\(index)"
                if shouldShow(key: key, answer: answer) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Đoạn \(index + 1)")
                            .font(.subheadline.bold())
                        Text(exercise.paragraphs[index])
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(isReviewing ? nil : 5)

                        selectionRow(
                            label: "Chọn heading",
                            key: key,
                            options: exercise.headings.map(\.id),
                            answer: answer,
                            optionLabel: { id in
                                guard let heading = exercise.headings.first(where: { $0.id == id }) else {
                                    return id
                                }
                                return "\(heading.label). \(heading.text)"
                            }
                        )
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private func selectionRow(
        label: String,
        key: String,
        options: [String],
        answer: String,
        optionLabel: @escaping (String) -> String = { $0 }
    ) -> some View {
        let selection = selections[key]
        let isCorrect = selection == answer

        return VStack(alignment: .leading, spacing: 7) {
            Text(label)
                .font(.body.weight(.medium))

            Menu {
                ForEach(options, id: \.self) { option in
                    Button(optionLabel(option)) {
                        selections[key] = option
                    }
                }
            } label: {
                HStack {
                    Text(selection.map(optionLabel) ?? "Chọn đáp án")
                        .foregroundStyle(selection == nil ? .secondary : .primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: reviewIcon(isCorrect: isCorrect))
                        .foregroundStyle(reviewTint(isCorrect: isCorrect))
                }
                .padding(12)
                .background(reviewBackground(isCorrect: isCorrect), in: RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .disabled(isReviewing)

            if isReviewing {
                Label(
                    "Đáp án đúng: \(optionLabel(answer))",
                    systemImage: "lightbulb.fill"
                )
                .font(.caption.bold())
                .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 3)
    }

    private var perfectResult: some View {
        VStack(spacing: 14) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 56))
                .foregroundStyle(.green)
            Text("Không có câu sai!")
                .font(.title2.bold())
            Text("Bạn đã trả lời đúng toàn bộ \(totalAnswerCount) đáp án.")
                .foregroundStyle(.secondary)
        }
        .tryhardCard()
    }

    private func actionBar(proxy: ScrollViewProxy) -> some View {
        VStack(spacing: 7) {
            if !isReviewing && !isComplete {
                Text("Còn \(totalAnswerCount - answeredCount) mục chưa trả lời")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Button {
                if isReviewing {
                    if reviewKeys.isEmpty {
                        restartAll()
                    } else {
                        continueWrongAnswers()
                    }
                } else {
                    let wrongKeys = Set(
                        activeKeys.filter { key in
                            selections[key] != answer(for: key)
                        }
                    )
                    reviewKeys = wrongKeys
                    reviewItems = items.filter { item in
                        Self.answerPairs(for: item).contains {
                            wrongKeys.contains($0.key)
                        }
                    }
                    withAnimation {
                        isReviewing = true
                    }
                    proxy.scrollTo("reading-tryhard-top", anchor: .top)
                }
            } label: {
                Label(
                    reviewActionTitle,
                    systemImage: isReviewing ? "arrow.right.circle.fill" : "checkmark.circle.fill"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background((isReviewing ? Color.indigo : Color.blue).opacity(0.17), in: Capsule())
                .foregroundStyle(isReviewing ? .indigo : .blue)
            }
            .buttonStyle(.plain)
            .disabled(!isReviewing && !isComplete)
            .opacity(isReviewing || isComplete ? 1 : 0.45)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }

    private func shouldShow(key: String, answer: String) -> Bool {
        isReviewing ? reviewKeys.contains(key) : activeKeys.contains(key)
    }

    private func reviewIcon(isCorrect: Bool) -> String {
        guard isReviewing else { return "chevron.up.chevron.down" }
        return isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
    }

    private func reviewTint(isCorrect: Bool) -> Color {
        guard isReviewing else { return .secondary }
        return isCorrect ? .green : .red
    }

    private func reviewBackground(isCorrect: Bool) -> Color {
        guard isReviewing else { return Color.gray.opacity(0.08) }
        return (isCorrect ? Color.green : Color.red).opacity(0.10)
    }

    private var reviewActionTitle: String {
        guard isReviewing else { return "Kiểm tra" }
        return reviewKeys.isEmpty
            ? "Làm lại toàn bộ"
            : "Làm tiếp \(reviewKeys.count) câu sai"
    }

    private func answer(for key: String) -> String? {
        for item in items {
            if let pair = Self.answerPairs(for: item).first(where: { $0.key == key }) {
                return pair.answer
            }
        }
        return nil
    }

    private func continueWrongAnswers() {
        activeKeys = reviewKeys
        items = reviewItems.shuffled()
        for key in activeKeys {
            selections.removeValue(forKey: key)
        }
        reviewItems.removeAll()
        reviewKeys.removeAll()
        withAnimation {
            isReviewing = false
        }
    }

    private func restartAll() {
        items = allItems.shuffled()
        activeKeys = Set(allItems.flatMap(Self.answerPairs).map(\.key))
        selections.removeAll()
        reviewItems.removeAll()
        reviewKeys.removeAll()
        withAnimation {
            isReviewing = false
        }
    }

    private static func answerPairs(
        for item: ReadingTryhardItem
    ) -> [(key: String, answer: String)] {
        switch item.kind {
        case .gap(let exercise):
            return exercise.gaps.map {
                ("\(item.id)-gap-\($0.id)", $0.correctAnswer)
            }
        case .ordering(_, let exercise):
            return exercise.correctOrder.indices.map {
                ("\(item.id)-order-\($0)", String(exercise.correctOrder[$0]))
            }
        case .people(let exercise):
            return exercise.questions.map {
                ("\(item.id)-person-\($0.id)", $0.correctPerson)
            }
        case .headings(let exercise):
            return exercise.correctOrder.indices.map {
                ("\(item.id)-heading-\($0)", exercise.correctOrder[$0])
            }
        }
    }
}

private extension View {
    func tryhardCard() -> some View {
        padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
            }
    }
}
