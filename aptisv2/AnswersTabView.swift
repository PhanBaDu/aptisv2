//
//  AnswersTabView.swift
//  aptisv2
//
//  Created by Cursor on 29/6/26.
//

import SwiftUI

struct AnswersTabView: View {
    private let items = [
        "Listening",
        "Reading",
        "Writing",
        "Speaking"
    ]

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
                        ForEach(items, id: \.self) { item in
                            if item == "Reading" {
                                NavigationLink(destination: ReadingAnswersListView()) {
                                    AnswerCard(title: item)
                                }
                                .buttonStyle(.plain)
                            } else {
                                AnswerCard(title: item)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Answers")
        }
    }
}

private struct AnswerCard: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.green)

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text("View answers")
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
