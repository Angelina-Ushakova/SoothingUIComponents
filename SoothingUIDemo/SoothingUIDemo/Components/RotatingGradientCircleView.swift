//
//  Отдельный View для RotatingGradientCircle
//

import SwiftUI
import SoothingUIComponentsLibrary

/*
struct RotatingGradientCircleView: View {
    var body: some View {
        RotatingGradientCircle(size: 200, gradientColors: [Color(hex: "f35872"), Color(hex: "f99068")], rotationSpeed: 3)
            .navigationTitle("Rotating Gradient Circle")
    }
}
*/


struct RotatingGradientLoaderView: View {
    var body: some View {
        RotatingGradientLoader(mainCircleSize: 250, rotationLineSize: 275, capsuleWidth: 15, gradientColors: [.pink, .blue])
        .navigationTitle("Animated Gradient")
    }
}


import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}


