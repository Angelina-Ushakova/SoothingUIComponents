//
//  ViewModel для меню, которая будет содержать список элементов
//

import SwiftUI
import SoothingUIComponentsLibrary

class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = [
        MenuItem(name: "Progress Button", image: "ProgressButton", destination: AnyView(ProgressButtonView())),
        MenuItem(name: "Wave Button", image: "WaveButton", destination: AnyView(WaveButtonView())),
        MenuItem(name: "Rotating Gradient Loader", image: "RotatingGradientLoader", destination: AnyView(RotatingGradientLoaderView())),
        MenuItem(name: "Bubble Button", image: "BubbleButton", destination: AnyView(BubbleButtonView()))
        // Другие элементы будут здесь
    ]
}
