//
//  ReadingTabView.swift
//  aptisv2
//
//  Created by Cursor on 29/6/26.
//

import Foundation
import SwiftUI

struct ReadingTabView: View {
    private let lessons = Array(1...5)
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
                            ReadingCard(title: "Reading \(lesson.formattedAsTwoDigits)")
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Reading")
        }
    }
}

private struct ReadingCard: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "book.closed")
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
