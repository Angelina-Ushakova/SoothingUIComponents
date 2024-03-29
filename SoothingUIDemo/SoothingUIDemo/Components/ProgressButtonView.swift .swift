//
//  Отдельный View для ProgressButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct ProgressButtonView: View {
    var body: some View {
        ProgressButton(duration: 3, size: 250, color: .pink, action: {})
        .navigationTitle("Progress Button")
    }
}
