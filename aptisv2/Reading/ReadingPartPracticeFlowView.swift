import SwiftUI

struct ReadingPartPracticeFlowView: View {
    let targetPartIndex: Int // 0 to 4
    
    @State private var currentExamIndex: Int = 1
    @State private var isCompleted = false
    
    private let totalExams = 5
    
    private var examData: ReadingExamData {
        ReadingExamData.forExam(currentExamIndex)
    }

    var body: some View {
        ZStack {
            Color.gray.opacity(0.16)
                .ignoresSafeArea()

            if isCompleted {
                ReadingPartCompletionView(partName: "Part \(targetPartIndex + 1)")
            } else {
                partContent
                    .id(currentExamIndex) // Force refresh when exam changes
            }
        }
        .navigationTitle("Luyện tập Part \(targetPartIndex + 1)")
        .navigationBarTitleDisplayMode(.inline)
        .hidesTabBarWhenPushed()
        .toolbar {
            if !isCompleted {
                ToolbarItem(placement: .principal) {
                    ReadingProgressDots(current: currentExamIndex, total: totalExams)
                }
            }
        }
    }

    @ViewBuilder
    private var partContent: some View {
        switch targetPartIndex {
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
                onPass: { advance() }
            )
            
        default:
            EmptyView()
        }
    }

    private func advance() {
        if currentExamIndex < totalExams {
            withAnimation(.easeInOut(duration: 0.25)) {
                currentExamIndex += 1
            }
        } else {
            finishPractice()
        }
    }

    private func finishPractice() {
        withAnimation {
            isCompleted = true
        }
    }
}

struct ReadingPartCompletionView: View {
    let partName: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 56))
                .foregroundStyle(.primary)

            Text("Hoàn thành \(partName)!")
                .font(.title2.bold())

            Text("Bạn đã luyện tập xong tất cả các bộ đề.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(28)
        .frame(maxWidth: .infinity)
        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
        )
        .padding()
    }
}
