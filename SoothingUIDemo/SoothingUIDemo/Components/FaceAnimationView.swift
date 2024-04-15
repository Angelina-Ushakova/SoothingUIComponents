//
//  Отдельный View для FaceAnimation
//

import SwiftUI
import SoothingUIComponentsLibrary

struct FaceAnimationView: View {
    var body: some View {
        FaceAnimation(size: 250, faceColor: .pink.opacity(0.7))
        .navigationTitle("Face Animation")
    }
}
