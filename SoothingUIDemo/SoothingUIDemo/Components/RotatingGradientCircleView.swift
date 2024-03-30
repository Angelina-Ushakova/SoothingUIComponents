//
//  Отдельный View для RotatingGradientLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct RotatingGradientLoaderView: View {
    var body: some View {
        RotatingGradientLoader(mainCircleSize: 250, rotationLineSize: 275, capsuleWidth: 15, gradientColors: [.pink, .blue])
        .navigationTitle("Rotating Gradient Loader")
    }
}
