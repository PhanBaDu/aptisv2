import Foundation
import SwiftUI

struct ListeningTabView: View {
    private let exams = ListeningExamStore.exams

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(exams) { exam in
                            NavigationLink {
                                ListeningExamView(exam: exam)
                            } label: {
                                ListeningPracticeCard(
                                    title: exam.title,
                                    questionCount: exam.answerCount
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Listening")
        }
    }
}

private struct ListeningPracticeCard: View {
    let title: String
    let questionCount: Int

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "ear")
                .font(.title2.weight(.medium))
                .foregroundStyle(.primary)
                .frame(width: 48, height: 48)
                .background(Color.gray.opacity(0.1), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("\(questionCount) câu trả lời · Tap to start")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.body.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        )
    }
}
