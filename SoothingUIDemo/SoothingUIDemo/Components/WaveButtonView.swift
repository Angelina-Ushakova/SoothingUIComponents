//
//  Отдельный View для WaveButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct WaveButtonView: View {
    var body: some View {
        // Использование `WaveButton` с параметрами размера и цвета.
        WaveButton(size: 250, waveColor: .pink, action: {})
        .navigationTitle("Wave Button")
    }
}

