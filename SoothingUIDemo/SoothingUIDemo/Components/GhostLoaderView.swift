//
//  Отдельный View для GhostLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct GhostLoaderView: View {
    var body: some View {
        GhostLoader(ghostSize: 200, ghostColor: .white)
        .navigationTitle("Ghost Loader")
    }
}
