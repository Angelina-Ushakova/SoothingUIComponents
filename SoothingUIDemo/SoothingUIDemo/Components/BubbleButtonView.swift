//
//  BubbleButtonView.swift
//

import SwiftUI
import SoothingUIComponentsLibrary

struct BubbleButtonView: View {
    var body: some View {
        VStack {
            BubbleButton(size: 200, color: .pink, action: {})
            .navigationTitle("Bubble Button")
        }
    }
}
