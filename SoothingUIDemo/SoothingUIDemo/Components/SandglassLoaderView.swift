//
//  Отдельный View для SandglassLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct SandglassLoaderView: View {
    var body: some View {
        SandglassLoader(size: 200, frameColor: .black, sandColor: .pink, animationDuration: 2.5)
        .navigationTitle("Sandglass Loader")
    }
}
