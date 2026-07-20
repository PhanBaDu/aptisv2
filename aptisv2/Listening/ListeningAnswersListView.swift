import SwiftUI

struct ListeningAnswersListView: View {
    private let exams = ListeningExamStore.exams
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            Color.gray.opacity(0.16)
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(exams) { exam in
                        NavigationLink {
                            ListeningAnswerDetailView(exam: exam)
                        } label: {
                            ListeningAnswerCard(title: exam.title)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Listening Answers")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
    }
}

private struct ListeningAnswerCard: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "ear.badge.checkmark")
                .font(.title2.weight(.semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.green)

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
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        }
    }
}
