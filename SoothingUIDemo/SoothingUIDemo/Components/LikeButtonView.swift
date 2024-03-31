//
//  Отдельный View для LikeButton
//

import SwiftUI
import SoothingUIComponentsLibrary

struct LikeButtonView: View {
    var body: some View {
        LikeButton(initialLikes: 3, size: 170, activeColor: .pink, inactiveColor: .gray, action: {})
        .navigationTitle("Like Button")
    }
}
