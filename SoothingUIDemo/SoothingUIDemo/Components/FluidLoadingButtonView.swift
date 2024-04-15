//
//  Отдельный View для FluidLoadingButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct FluidLoadingButtonView: View {
    var body: some View {
        FluidLoadingButton(height: 350, fluidSpeed: 1.5, waveHeight: 20, foregroundColor: LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .top, endPoint: .bottom), backgroundColor: .purple)
        .navigationTitle("Fluid Loading Button")
    }
}

