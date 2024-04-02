import SwiftUI

/// `SwingLoader` - индикатор загрузки, который анимируется в виде качающегося маятника.
///
/// При появлении элемента на экране, маятник начинает качаться вверх и вниз, создавая динамичный визуальный эффект.
///
/// ## Пример использования:
/// Вставьте `SwingLoader` в ваш SwiftUI View, укажите размер, цвета и длительность анимации.
///
/// ```
/// SwingLoader(size: 100, duration: 2.0, loaderColor: .blue, backgroundCircleColor: .gray)
/// ```
///
/// - Requires: `SwiftUI`
public struct SwingLoader: View {
    @State private var startTrim: CGFloat = 0.20 // Начальная точка отсечения для анимации
    @State private var endTrim: CGFloat = 0.201 // Конечная точка отсечения для анимации
    @State private var verticalPosition: CGFloat = 60 // Начальное смещение для анимации

    private let mainSize: CGFloat // Общий размер элемента
    private let animationDuration: Double // Длительность анимации
    private let loaderColor: Color // Цвет индикатора загрузки
    private let backgroundCircleColor: Color // Цвет фона круга

    /// Инициализатор для `SwingLoader`.
    /// - Parameters:
    ///   - size: Размер индикатора загрузки.
    ///   - duration: Длительность анимации качения.
    ///   - loaderColor: Цвет анимируемой части индикатора.
    ///   - backgroundCircleColor: Цвет фона круга.
    public init(size: CGFloat, duration: Double, loaderColor: Color, backgroundCircleColor: Color) {
        self.mainSize = size * 2
        self.animationDuration = duration
        self.loaderColor = loaderColor
        self.backgroundCircleColor = backgroundCircleColor
    }

    private var strokeThickness: CGFloat {
        mainSize * 0.065 // Толщина линии индикатора
    }

    public var body: some View {
        ZStack {
            // Фоновый круг
            Circle()
                .stroke(lineWidth: strokeThickness)
                .foregroundColor(backgroundCircleColor)
                .frame(width: mainSize / 2, height: mainSize / 2)
                .offset(y: verticalPosition)
            // Качающийся маятник
            Capsule()
                .trim(from: startTrim, to: endTrim)
                .stroke(loaderColor, style: StrokeStyle(lineWidth: strokeThickness, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: mainSize, height: mainSize / 2)
                .offset(x: 0, y: -mainSize / 4)
                .offset(y: verticalPosition)
        }
        .onAppear {
            animateLoader()
        }
    }

    private func animateLoader() {
        withAnimation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
            // Анимация изменения параметров отсечения и смещения для создания эффекта качения
            startTrim = 0.80
            endTrim = 0.801
            verticalPosition -= 60
        }
    }
}
