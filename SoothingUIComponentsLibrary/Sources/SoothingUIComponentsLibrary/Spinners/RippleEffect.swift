import SwiftUI

/// `RippleEffect` - визуальный индикатор в виде расширяющихся кругов.
///
/// Компонент создаёт серию пульсирующих кругов, которые появляются и исчезают, образуя динамичный визуальный эффект.
///
/// ## Пример использования:
///
/// Вставьте `RippleEffect` в ваш SwiftUI View, задав цвет, размер и скорость анимации.
///
/// ```
/// RippleEffect(color: .blue, size: 100, duration: 1.0)
/// ```
///
/// - Requires: `SwiftUI`
public struct RippleEffect: View {
    /// Флаг активности анимации.
    @State private var isActive: Bool = false
    /// Длительность анимации в секундах.
    private var duration: Double
    /// Размер индикатора.
    private var size: CGFloat
    /// Цвет элементов индикатора.
    private var color: Color
    
    @State private var yOffset: CGFloat = -60  // Начальное смещение
    
    /// Инициализатор `RippleEffect`.
    /// - Parameters:
    ///   - color: Цвет анимируемых кругов.
    ///   - size: Размер индикатора.
    ///   - duration: Длительность анимации.
    public init(color: Color = .black, size: CGFloat = 50, duration: Double = 0.5) {
        self.duration = duration
        self.size = size
        self.color = color
    }
    
    /// Тело `RippleEffect`, описывающее визуальное представление индикатора.
    public var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .stroke(
                        color.opacity(isActive ? 0.0 : 1.0),
                        style: StrokeStyle(lineWidth: isActive ? 0.0 : (size / 10))
                    )
                    .frame(width: size, height: size, alignment: .center)
                    .offset(y: yOffset)
                    .scaleEffect(isActive ? 1.0 : 0.0)
                    .animation(
                        Animation.easeOut(duration: duration)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * duration / 3 / 3),
                        value: isActive
                    )
            }
        }
        .frame(width: size, height: size, alignment: .center)
        .offset(y: -1 * yOffset)
        .onAppear {
            withAnimation {
                isActive.toggle()
            }
        }
    }
}
