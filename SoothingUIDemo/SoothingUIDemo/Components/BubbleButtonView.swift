//
//  Отдельный View для BubbleButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct BubbleButtonView: View {
    var body: some View {
        BubbleButton(size: 220, color: .pink, action: {})
        .navigationTitle("Bubble Button")
    }
}
