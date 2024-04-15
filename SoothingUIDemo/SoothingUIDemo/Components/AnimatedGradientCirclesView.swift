//
//  Отдельный View для AnimatedGradientCircles
//

import SwiftUI
import SoothingUIComponentsLibrary

struct AnimatedGradientCirclesView: View {
    var body: some View {
        AnimatedGradientCircles(size: 250, primaryColor: .pink, secondaryColor: .blue, animationSpeed: 1.8)
        .navigationTitle("Animated Gradient Circles")
    }
}
