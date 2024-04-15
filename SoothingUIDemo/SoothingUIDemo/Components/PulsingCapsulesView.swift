//
//  Отдельный View для PulsingCapsules
//

import SwiftUI
import SoothingUIComponentsLibrary

struct PulsingCapsulesView: View {
    var body: some View {
        PulsingCapsules(capsuleWidth: 10, capsuleHeight: 70, color: .pink, numberOfCapsules: 12, animationDuration: 2)
        .navigationTitle("Pulsing Capsules")
    }
}
