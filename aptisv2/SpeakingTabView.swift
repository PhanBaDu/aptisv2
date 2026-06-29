//
//  SpeakingTabView.swift
//  aptisv2
//
//  Created by Cursor on 29/6/26.
//

import SwiftUI

struct SpeakingTabView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "mic")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundStyle(.tint)

                Text("Speaking")
                    .font(.largeTitle.bold())

                Text("Speaking practice goes here.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Speaking")
        }
    }
}
