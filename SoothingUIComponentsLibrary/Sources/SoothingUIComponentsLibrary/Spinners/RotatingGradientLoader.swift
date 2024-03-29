import SwiftUI

/// `RotatingGradientLoader` - визуализирует анимированное вращение с градиентным эффектом.
///
/// Этот элемент представляет собой круг с анимированными линиями и полосками,
/// создающими динамичный и визуально привлекательный эффект загрузки.
///
/// ## Пример использования:
///
/// Вставьте `RotatingGradientLoader` в ваш SwiftUI View и укажите нужные параметры размера, ширины и цветов градиента.
///
/// ```
/// RotatingGradientLoader(mainCircleSize: 200, rotationLineSize: 180, capsuleWidth: 5, gradientColors: [.blue, .purple])
/// ```
///
/// - Parameters:
///   - mainCircleSize: Размер основного круга.
///   - rotationLineSize: Размер вращающегося круга с чёрточками.
///   - capsuleWidth: Ширина каждой анимированной полоски (капсулы).
///   - gradientColors: Массив цветов для градиента.
public struct RotatingGradientLoader: View {
    @State private var rotationDegrees: Double = 0  // Начальное значение для вращения
    @State private var scale: CGFloat = 0.5  // Начальное значение для масштаба

    // Параметры для настройки вида элемента
    var mainCircleSize: CGFloat
    var rotationLineSize: CGFloat
    var capsuleWidth: CGFloat
    var gradientColors: [Color]

    /// Инициализатор для создания вью с заданными параметрами.
    public init(mainCircleSize: CGFloat, rotationLineSize: CGFloat, capsuleWidth: CGFloat, gradientColors: [Color]) {
        self.mainCircleSize = mainCircleSize
        self.rotationLineSize = rotationLineSize
        self.capsuleWidth = capsuleWidth
        self.gradientColors = gradientColors
    }

    public var body: some View {
        ZStack {
            // Основной круг с градиентной заливкой
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                .frame(width: mainCircleSize, height: mainCircleSize)
            
            // Вращающиеся чёрточки на круге
            let dashWidth = capsuleWidth / 2
            Circle()
                .trim(from: 0, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: dashWidth, lineCap: .round, dash: [dashWidth, dashWidth * 3]))
                .frame(width: rotationLineSize, height: rotationLineSize)
                .rotationEffect(.degrees(rotationDegrees))
                .onAppear {
                    withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                        rotationDegrees = 360  // Анимация для полного вращения
                    }
                }

            // Анимированные полоски (капсулы), изменяющие размер
            let capsuleMaxHeight = mainCircleSize / 3
            HStack(spacing: capsuleWidth / 2) {
                ForEach(0..<5, id: \.self) { index in
                    Capsule()
                        .fill(Color.white)
                        .frame(width: capsuleWidth, height: capsuleMaxHeight * (scale + CGFloat(index) * 0.1))
                }
            }
            .frame(width: rotationLineSize, height: mainCircleSize, alignment: .center)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    scale = 1.0  // Плавное изменение масштаба для анимации полосок
                }
            }
        }
    }
}
