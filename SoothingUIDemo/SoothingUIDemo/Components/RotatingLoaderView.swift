//
//  RotatingLoaderView.swift
//  Демо представление для RotatingLoader
//

import SwiftUI
import SoothingUIComponentsLibrary

struct RotatingLoaderView: View {
    var body: some View {
        RotatingLoader(largeCircleSize: 230, smallCircleSize: 100, color: .pink, animationDuration: 2)
            .navigationTitle("Rotating Loader")
    }
}
