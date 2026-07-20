import SwiftUI

struct RandomTabView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.16)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    Image(systemName: "shuffle.circle.fill")
                        .font(.system(size: 58))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.purple)

                    Text("Random Practice")
                        .font(.title2.bold())

                    Text("Các bài luyện tập ngẫu nhiên sẽ được hiển thị tại đây.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(28)
                .frame(maxWidth: .infinity)
                .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(.gray.opacity(0.12), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("Random")
        }
    }
}
