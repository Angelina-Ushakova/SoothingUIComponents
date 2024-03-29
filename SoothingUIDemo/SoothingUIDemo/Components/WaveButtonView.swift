//
//  Отдельный View для WaveButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct WaveButtonView: View {
    var body: some View {
        WaveButton(size: 250, waveColor: .pink, action: {})
        .navigationTitle("Wave Button")
    }
}
