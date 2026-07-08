import SwiftUI

struct ReadingAnswerData {
    let title: String
    
    struct GapAnswer: Hashable { let index: Int; let word: String }
    let part1: [GapAnswer]
    
    let part2Title: String
    let part2: [String]
    
    let part3Title: String
    let part3: [String]
    
    struct MatchAnswer: Hashable { let index: Int; let question: String; let answer: String }
    let part4: [MatchAnswer]
    
    struct HeadingAnswer: Hashable { let index: Int; let headingId: String; let headingText: String }
    let part5: [HeadingAnswer]
}

struct ReadingAnswerDetailView: View {
    let examIndex: Int
    
    private var data: ReadingAnswerData {
        ReadingAnswerData.forExam(examIndex)
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.16)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    part1Section
                    part2Section
                    part3Section
                    part4Section
                    part5Section
                }
                .padding()
                .padding(.bottom, 24)
            }
        }
        .navigationTitle(data.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var part1Section: some View {
        answerCard(title: "Part 1: Gap Fill") {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(data.part1, id: \.self) { item in
                    HStack {
                        Text("\(item.index).")
                            .font(.subheadline.bold())
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .leading)
                        Text(item.word)
                            .font(.body.weight(.medium))
                            .foregroundStyle(.green)
                    }
                }
            }
        }
    }
    
    private var part2Section: some View {
        answerCard(title: "Part 2: \(data.part2Title)") {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(data.part2.enumerated()), id: \.offset) { index, sentence in
                    HStack(alignment: .top) {
                        Text("\(index + 1).")
                            .font(.subheadline.bold())
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .leading)
                        Text(sentence)
                            .font(.body)
                    }
                }
            }
        }
    }
    
    private var part3Section: some View {
        answerCard(title: "Part 3: \(data.part3Title)") {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(data.part3.enumerated()), id: \.offset) { index, sentence in
                    HStack(alignment: .top) {
                        Text("\(index + 1).")
                            .font(.subheadline.bold())
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .leading)
                        Text(sentence)
                            .font(.body)
                    }
                }
            }
        }
    }
    
    private var part4Section: some View {
        answerCard(title: "Part 4: Person Matching") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(data.part4, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(item.index). \(item.question)")
                            .font(.body)
                        HStack {
                            Image(systemName: "arrow.turn.down.right")
                                .foregroundStyle(.secondary)
                            Text(item.answer)
                                .font(.subheadline.bold())
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
        }
    }
    
    private var part5Section: some View {
        answerCard(title: "Part 5: Heading Matching") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(data.part5, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Đoạn \(item.index)")
                            .font(.subheadline.bold())
                        HStack(alignment: .top) {
                            Text("\(item.headingId).")
                                .font(.body.bold())
                                .foregroundStyle(.green)
                            Text(item.headingText)
                                .font(.body)
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
        }
    }
    
    private func answerCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ReadingSectionLabel(title: title)
            
            content()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
                )
        }
    }
}

extension ReadingAnswerData {
    static func forExam(_ index: Int) -> ReadingAnswerData {
        switch index {
        case 1:
            return ReadingAnswerData(
                title: "Reading 01",
                part1: Reading01GapFill.gaps.map { GapAnswer(index: $0.id, word: $0.correctAnswer) },
                part2Title: Reading01Ordering.filmMaking.topicTitle,
                part2: Reading01Ordering.filmMaking.correctOrder.map { Reading01Ordering.filmMaking.sentences[$0] },
                part3Title: Reading01Ordering.familySportDay.topicTitle,
                part3: Reading01Ordering.familySportDay.correctOrder.map { Reading01Ordering.familySportDay.sentences[$0] },
                part4: Reading01PersonMatching.questions.map { MatchAnswer(index: $0.id, question: $0.question, answer: $0.correctPerson) },
                part5: Array(Reading01HeadingMatching.correctOrder.enumerated()).map { idx, hId in
                    let text = Reading01HeadingMatching.headings.first { $0.id == hId }?.text ?? ""
                    return HeadingAnswer(index: idx + 1, headingId: hId, headingText: text)
                }
            )
        case 2:
            return ReadingAnswerData(
                title: "Reading 02",
                part1: Reading02GapFill.gaps.map { GapAnswer(index: $0.id, word: $0.correctAnswer) },
                part2Title: Reading02Ordering.firstAmericanWoman.topicTitle,
                part2: Reading02Ordering.firstAmericanWoman.correctOrder.map { Reading02Ordering.firstAmericanWoman.sentences[$0] },
                part3Title: Reading02Ordering.musicShow.topicTitle,
                part3: Reading02Ordering.musicShow.correctOrder.map { Reading02Ordering.musicShow.sentences[$0] },
                part4: Reading02PersonMatching.questions.map { MatchAnswer(index: $0.id, question: $0.question, answer: $0.correctPerson) },
                part5: Array(Reading02HeadingMatching.correctOrder.enumerated()).map { idx, hId in
                    let text = Reading02HeadingMatching.headings.first { $0.id == hId }?.text ?? ""
                    return HeadingAnswer(index: idx + 1, headingId: hId, headingText: text)
                }
            )
        case 3:
            return ReadingAnswerData(
                title: "Reading 03",
                part1: Reading03GapFill.gaps.map { GapAnswer(index: $0.id, word: $0.correctAnswer) },
                part2Title: Reading03Ordering.collegeWelcomingDay.topicTitle,
                part2: Reading03Ordering.collegeWelcomingDay.correctOrder.map { Reading03Ordering.collegeWelcomingDay.sentences[$0] },
                part3Title: Reading03Ordering.historyOfTravel.topicTitle,
                part3: Reading03Ordering.historyOfTravel.correctOrder.map { Reading03Ordering.historyOfTravel.sentences[$0] },
                part4: Reading03PersonMatching.questions.map { MatchAnswer(index: $0.id, question: $0.question, answer: $0.correctPerson) },
                part5: Array(Reading03HeadingMatching.correctOrder.enumerated()).map { idx, hId in
                    let text = Reading03HeadingMatching.headings.first { $0.id == hId }?.text ?? ""
                    return HeadingAnswer(index: idx + 1, headingId: hId, headingText: text)
                }
            )
        case 4:
            return ReadingAnswerData(
                title: "Reading 04",
                part1: Reading04GapFill.gaps.map { GapAnswer(index: $0.id, word: $0.correctAnswer) },
                part2Title: Reading04Ordering.aSinger.topicTitle,
                part2: Reading04Ordering.aSinger.correctOrder.map { Reading04Ordering.aSinger.sentences[$0] },
                part3Title: Reading04Ordering.endTermProject.topicTitle,
                part3: Reading04Ordering.endTermProject.correctOrder.map { Reading04Ordering.endTermProject.sentences[$0] },
                part4: Reading04PersonMatching.questions.map { MatchAnswer(index: $0.id, question: $0.question, answer: $0.correctPerson) },
                part5: Array(Reading04HeadingMatching.correctOrder.enumerated()).map { idx, hId in
                    let text = Reading04HeadingMatching.headings.first { $0.id == hId }?.text ?? ""
                    return HeadingAnswer(index: idx + 1, headingId: hId, headingText: text)
                }
            )
        case 5:
            return ReadingAnswerData(
                title: "Reading 05",
                part1: Reading05GapFill.gaps.map { GapAnswer(index: $0.id, word: $0.correctAnswer) },
                part2Title: Reading05Ordering.newCafeInTown.topicTitle,
                part2: Reading05Ordering.newCafeInTown.correctOrder.map { Reading05Ordering.newCafeInTown.sentences[$0] },
                part3Title: Reading05Ordering.homeworkNextWeek.topicTitle,
                part3: Reading05Ordering.homeworkNextWeek.correctOrder.map { Reading05Ordering.homeworkNextWeek.sentences[$0] },
                part4: Reading05PersonMatching.questions.map { MatchAnswer(index: $0.id, question: $0.question, answer: $0.correctPerson) },
                part5: Array(Reading05HeadingMatching.correctOrder.enumerated()).map { idx, hId in
                    let text = Reading05HeadingMatching.headings.first { $0.id == hId }?.text ?? ""
                    return HeadingAnswer(index: idx + 1, headingId: hId, headingText: text)
                }
            )
        default:
            return ReadingAnswerData(title: "Not Found", part1: [], part2Title: "", part2: [], part3Title: "", part3: [], part4: [], part5: [])
        }
    }
}
