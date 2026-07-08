import SwiftUI

enum LiquidGlass {
    static let cardRadius: CGFloat = 20
    static let rowRadius: CGFloat = 16
    static let chipRadius: CGFloat = 12

    static var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cardRadius, style: .continuous)
    }

    static var rowShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: rowRadius, style: .continuous)
    }

    static var chipShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: chipRadius, style: .continuous)
    }

    static var buttonShape: Capsule { .capsule }

    static func glass(_ tint: Color? = nil, interactive: Bool = false) -> Glass {
        var material = Glass.regular
        if let tint {
            material = material.tint(tint)
        }
        if interactive {
            material = material.interactive()
        }
        return material
    }
}

struct ReadingLiquidBackground: View {
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: [
                Color(red: 0.72, green: 0.84, blue: 1.0),
                Color(red: 0.82, green: 0.78, blue: 1.0),
                Color(red: 0.76, green: 0.90, blue: 0.98),
                Color(red: 0.88, green: 0.80, blue: 0.98),
                Color(red: 0.78, green: 0.88, blue: 1.0),
                Color(red: 0.84, green: 0.76, blue: 0.96),
                Color(red: 0.80, green: 0.92, blue: 0.98),
                Color(red: 0.90, green: 0.84, blue: 1.0),
                Color(red: 0.74, green: 0.86, blue: 0.96)
            ]
        )
        .ignoresSafeArea()
    }
}

struct ReadingSectionLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.subheadline.bold())
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
    }
}

struct ReadingPartHeader: View {
    let part: String
    let instruction: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(part)
                .font(.title2.bold())

            Text(instruction)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

struct ReadingContentCard<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
            )
    }
}

struct ReadingGlassRow<Content: View>: View {
    let tint: Color?
    let interactive: Bool
    @ViewBuilder let content: () -> Content

    init(tint: Color? = nil, interactive: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.tint = tint
        self.interactive = interactive
        self.content = content
    }

    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(tint ?? .white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
            )
    }
}

struct ReadingGlassChip<Content: View>: View {
    let tint: Color?
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .frame(minWidth: 52, minHeight: 36)
            .background(tint ?? Color.gray.opacity(0.1), in: Capsule())
    }
}

struct ReadingGlassButton: View {
    let title: String
    let systemImage: String?
    let tint: Color
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                if let systemImage {
                    Label(title, systemImage: systemImage)
                } else {
                    Text(title)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(.horizontal, 24)
            .background(tint.opacity(0.15), in: Capsule())
            .foregroundStyle(tint)
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.45)
        .disabled(!isEnabled)
    }
}

struct ReadingProgressDots: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...total, id: \.self) { index in
                Circle()
                    .fill(index <= current ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: index <= current ? 9 : 7, height: index <= current ? 9 : 7)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.white, in: Capsule())
    }
}

enum AnswerFeedbackTint {
    static func forCheckState(_ state: AnswerCheckState, isCorrect: Bool) -> Color? {
        switch state {
        case .idle:
            return nil
        case .correct:
            return .green
        case .incorrect:
            return isCorrect ? .green : .red
        }
    }

    static func actionTint(for state: AnswerCheckState) -> Color {
        switch state {
        case .idle: return .blue
        case .correct: return .green
        case .incorrect: return .orange
        }
    }
}
