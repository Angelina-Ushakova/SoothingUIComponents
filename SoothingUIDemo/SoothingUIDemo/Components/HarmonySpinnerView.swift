//
//  Отдельный View для HarmonySpinner
//

import SwiftUI
import SoothingUIComponentsLibrary

struct HarmonySpinnerView: View {
    var body: some View {
        HarmonySpinner(rotationTime: 2.5, size: 250, colors: [.blue, .purple, .pink])
        .navigationTitle("Harmony Spinner")
    }
}
