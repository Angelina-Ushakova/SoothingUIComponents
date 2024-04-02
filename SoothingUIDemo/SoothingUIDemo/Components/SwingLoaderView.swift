//
//  Отдельный View для SwingLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct SwingLoaderView: View {
    var body: some View {
        SwingLoader(size: 220, duration: 1.5, loaderColor: .black, backgroundCircleColor: .pink)
        .navigationTitle("Swing Loader")
    }
}
