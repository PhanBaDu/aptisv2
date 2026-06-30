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
                ReadingLiquidBackground()

                ScrollView {
                    GlassEffectContainer(spacing: 12) {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(lessons, id: \.self) { lesson in
                                NavigationLink {
                                    ReadingFlowView(examIndex: lesson)
                                } label: {
                                    ReadingCard(title: "Reading \(lesson.formattedAsTwoDigits)")
                                }
                                .buttonStyle(.plain)
                            }
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
    var isEnabled: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "book.closed")
                .font(.title2.weight(.semibold))
                .symbolRenderingMode(.hierarchical)

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text("Tap to start")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding()
        .contentShape(LiquidGlass.cardShape)
        .glassEffect(
            LiquidGlass.glass(
                isEnabled ? .blue.opacity(0.25) : nil,
                interactive: false
            ),
            in: LiquidGlass.cardShape
        )
    }
}

private extension Int {
    var formattedAsTwoDigits: String {
        String(format: "%02d", self)
    }
}
