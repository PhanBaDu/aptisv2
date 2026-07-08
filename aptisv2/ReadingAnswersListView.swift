import SwiftUI

struct ReadingAnswersListView: View {
    private let lessons = Array(1...5)
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            Color.gray.opacity(0.16)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 12) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(lessons, id: \.self) { lesson in
                            NavigationLink {
                                ReadingAnswerDetailView(examIndex: lesson)
                            } label: {
                                ReadingAnswerCard(title: "Reading \(lesson.formattedAsTwoDigits)")
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Reading Answers")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }
}

private struct ReadingAnswerCard: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "book.closed.fill")
                .font(.title2.weight(.semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.blue)

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text("View Keys")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        )
    }
}

private extension Int {
    var formattedAsTwoDigits: String {
        String(format: "%02d", self)
    }
}
