import Foundation

struct ListeningExam: Codable, Identifiable {
    let id: String
    let title: String
    let mc: [ListeningMultipleChoiceQuestion]
    let q14: ListeningSpeakerQuestion
    let q15: ListeningOpinionQuestion

    var answerCount: Int {
        mc.count + q14.speakers.count + q15.statements.count
    }
}

struct ListeningMultipleChoiceQuestion: Codable, Identifiable {
    let id: String
    let question: String
    let options: [String]
    let answer: String
}

struct ListeningSpeakerQuestion: Codable {
    let topic: String
    let options: [String]
    let answers: [String: String]

    var speakers: [String] {
        ["A", "B", "C", "D"]
    }
}

struct ListeningOpinionQuestion: Codable {
    let topic: String
    let topicVietnamese: String
    let firstSpeaker: ListeningFirstSpeaker
    let statements: [String]
    let answers: [String]
}

enum ListeningFirstSpeaker: String, Codable, CaseIterable, Identifiable {
    case man
    case woman

    var id: String { rawValue }

    var title: String {
        switch self {
        case .man: return "Nam nói trước"
        case .woman: return "Nữ nói trước"
        }
    }
}

enum ListeningExamStore {
    static let exams: [ListeningExam] = {
        guard let url = Bundle.main.url(
            forResource: "ListeningExams",
            withExtension: "json"
        ) else {
            assertionFailure("ListeningExams.json is missing from the app bundle.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([ListeningExam].self, from: data)
        } catch {
            assertionFailure("Unable to decode ListeningExams.json: \(error)")
            return []
        }
    }()

    static func exam(at index: Int) -> ListeningExam? {
        guard exams.indices.contains(index) else { return nil }
        return exams[index]
    }
}
