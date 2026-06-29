import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListeningTabView()
            .tabItem {
                Label("Listening", systemImage: "ear")
            }

            ReadingTabView()
            .tabItem {
                Label("Reading", systemImage: "book.closed")
            }

            WritingTabView()
            .tabItem {
                Label("Writing", systemImage: "pencil")
            }

            SpeakingTabView()
            .tabItem {
                Label("Speaking", systemImage: "mic")
            }

            AnswersTabView()
            .tabItem {
                Label("Answers", systemImage: "checkmark.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}
