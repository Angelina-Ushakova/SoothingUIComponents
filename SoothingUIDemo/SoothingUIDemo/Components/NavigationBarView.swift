//
//  Отдельный View для NavigationBar
//

import SwiftUI
import SoothingUIComponentsLibrary

struct NavigationBarView: View {
    var body: some View {
        NavigationBar(width: 300, height: 65,
                      items: [
                        NavigationBarItem(icon: "person.fill", color: .blue, action: {}),
                        NavigationBarItem(icon: "magnifyingglass", color: .purple, action: {}),
                        NavigationBarItem(icon: "heart.fill", color: .pink, action: {}),
                        NavigationBarItem(icon: "gearshape.fill", color: .gray, action: {})
                      ])
        .navigationTitle("Navigation Bar")
    }
}
