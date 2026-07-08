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
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        LazyVStack(spacing: 12) {
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
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    
                    Text("Luyện tập theo Part")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    VStack(spacing: 24) {
                        LazyVStack(spacing: 12) {
                            ForEach(0..<5, id: \.self) { partIndex in
                                NavigationLink {
                                    ReadingPartPracticeFlowView(targetPartIndex: partIndex)
                                } label: {
                                    ReadingCard(title: "Part \(partIndex + 1)", iconName: "puzzlepiece.extension")
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
    var iconName: String = "book.closed"
    var isEnabled: Bool = true

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.title2.weight(.medium))
                .foregroundStyle(.primary)
                .frame(width: 48, height: 48)
                .background(Color.gray.opacity(0.1), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("Tap to start")
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

private extension Int {
    var formattedAsTwoDigits: String {
        String(format: "%02d", self)
    }
}
