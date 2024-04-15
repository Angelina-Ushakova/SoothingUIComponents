//
//  Отдельный View для RippleEffect
//

import SwiftUI
import SoothingUIComponentsLibrary

struct RippleEffectView: View {
    var body: some View {
        RippleEffect(color: .pink, size: 250, duration: 1.5)
        .navigationTitle("Ripple Effect")
    }
}
