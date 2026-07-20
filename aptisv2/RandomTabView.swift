import SwiftUI

struct RandomTabView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        NavigationLink {
                            ListeningTryhardView()
                        } label: {
                            RandomPracticeCard(
                                title: "Listening Tryhard",
                                subtitle: "204 câu · Trộn ngẫu nhiên",
                                systemImage: "bolt.fill",
                                tint: .purple
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            ReadingTryhardView()
                        } label: {
                            RandomPracticeCard(
                                title: "Reading Tryhard",
                                subtitle: "25 bài · 145 đáp án · Trộn ngẫu nhiên",
                                systemImage: "book.pages.fill",
                                tint: .indigo
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding()
                }
            }
            .navigationTitle("Random")
        }
    }
}

private struct RandomPracticeCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let tint: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(tint)
                .frame(width: 50, height: 50)
                .background(tint.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.body.bold())
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        }
    }
}
