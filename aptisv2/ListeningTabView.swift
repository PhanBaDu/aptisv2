import Foundation
import SwiftUI

struct ListeningTabView: View {
    private let lessons = Array(1...20)
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(lessons, id: \.self) { lesson in
                            PracticeCard(
                                title: "Listening \(lesson.formattedAsTwoDigits)",
                                systemImage: "ear"
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Listening")
        }
    }
}

private struct PracticeCard: View {
    let title: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: systemImage)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.blue)

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text("Tap to start")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        )
    }
}

private extension Int {
    var formattedAsTwoDigits: String {
        String(format: "%02d", self)
    }
}
