//
//  ViewModel для управления данными меню в приложении
//

import SwiftUI
import SoothingUIComponentsLibrary

class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = [
        MenuItem(name: "Progress Button", image: "ProgressButton", destination: AnyView(ProgressButtonView())),
        MenuItem(name: "Wave Button", image: "WaveButton", destination: AnyView(WaveButtonView())),
        MenuItem(name: "Rotating Gradient Loader", image: "RotatingGradientLoader", destination: AnyView(RotatingGradientLoaderView())),
        MenuItem(name: "Bubble Button", image: "BubbleButton", destination: AnyView(BubbleButtonView())),
        MenuItem(name: "Rotating Circles", image: "RotatingCircles", destination: AnyView(RotatingCirclesView())),
        MenuItem(name: "Harmony Spinner", image: "HarmonySpinner", destination: AnyView(HarmonySpinnerView())),
        MenuItem(name: "Like Button", image: "LikeButton", destination: AnyView(LikeButtonView())),
        MenuItem(name: "Navigation Bar", image: "NavigationBar", destination: AnyView(NavigationBarView())),
        MenuItem(name: "Sandglass Loader", image: "SandglassLoader", destination: AnyView(SandglassLoaderView())),
        MenuItem(name: "Swing Loader", image: "SwingLoader", destination: AnyView(SwingLoaderView())),
        MenuItem(name: "Eternal Loader", image: "EternalLoader", destination: AnyView(EternalLoaderView())),
        MenuItem(name: "Rotating Loader", image: "RotatingLoader", destination: AnyView(RotatingLoaderView()))
        // Другие элементы будут здесь
    ]
}
