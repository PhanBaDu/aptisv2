import SwiftUI

struct ReadingFlowView: View {
    let examIndex: Int
    
    @State private var currentPartIndex: Int = 0
    @State private var isCompleted = false
    
    private let partsCount = 5
    private var examData: ReadingExamData {
        ReadingExamData.forExam(examIndex)
    }

    var body: some View {
        ZStack {
            ReadingLiquidBackground()

            if isCompleted {
                ReadingCompletionView(examIndex: examIndex)
            } else {
                partContent
            }
        }
        .navigationTitle("Reading \(String(format: "%02d", examIndex))")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
        .toolbar {
            if !isCompleted {
                ToolbarItem(placement: .principal) {
                    ReadingProgressDots(current: currentPartIndex + 1, total: partsCount)
                }
            }
        }
    }

    @ViewBuilder
    private var partContent: some View {
        switch currentPartIndex {
        case 0:
            GapFillPartView(
                exercise: examData.gapFill,
                onPass: { advance() }
            )

        case 1:
            SentenceOrderPartView(
                partNumber: 2,
                exercise: examData.orderingPart2,
                onPass: { advance() }
            )

        case 2:
            SentenceOrderPartView(
                partNumber: 3,
                exercise: examData.orderingPart3,
                onPass: { advance() }
            )

        case 3:
            PersonMatchingPartView(
                exercise: examData.personMatching,
                onPass: { advance() }
            )

        case 4:
            HeadingMatchingPartView(
                exercise: examData.headingMatching,
                onPass: { finishReading() }
            )
            
        default:
            EmptyView()
        }
    }

    private func advance() {
        if currentPartIndex < partsCount - 1 {
            withAnimation(.easeInOut(duration: 0.25)) {
                currentPartIndex += 1
            }
        } else {
            finishReading()
        }
    }

    private func finishReading() {
        withAnimation {
            isCompleted = true
        }
    }
}

struct ReadingCompletionView: View {
    let examIndex: Int
    
    var body: some View {
        GlassEffectContainer(spacing: 16) {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 56))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.green)

                Text("Hoàn thành Reading \(String(format: "%02d", examIndex))!")
                    .font(.title2.bold())

                Text("Bạn đã làm xong tất cả các part.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(28)
            .glassEffect(LiquidGlass.glass(.green.opacity(0.4), interactive: true), in: LiquidGlass.cardShape)
        }
        .padding()
    }
}
