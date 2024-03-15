//
//  ViewModel для меню, которая будет содержать список элементов
//

import SwiftUI
import SoothingUIComponentsLibrary

class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = [
        MenuItem(name: "Progress Button", image: "ProgressButton", destination: AnyView(ProgressButtonView()))
        // Другие элементы будут здесь
    ]
}
