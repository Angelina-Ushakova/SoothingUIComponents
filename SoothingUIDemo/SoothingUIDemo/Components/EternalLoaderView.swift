//
//  Отдельный View для EternalLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct EternalLoaderView: View {
    var body: some View {
        EternalLoader(size: 250, strokeWidth: 15, color: .pink, animationDuration: 2)
        .navigationTitle("Eternal Loader")
    }
}
