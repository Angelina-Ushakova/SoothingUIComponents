//
//  Отдельный View для RotatingCircles
//

import SwiftUI
import SoothingUIComponentsLibrary

struct RotatingCirclesView: View {
    var body: some View {
        RotatingCircles(size: 170, colors: [.blue, .pink, .purple], duration: 2)
        .navigationTitle("Rotating Circles")
    }
}
