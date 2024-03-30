import SwiftUI

/// `RotatingCircles` создает визуальный компонент, состоящий из вращающихся кругов.
///
/// Этот элемент включает в себя три круга, которые вращаются и изменяют свою позицию,
/// создавая анимированный и динамичный эффект. Размер и цвета кругов можно настроить.
///
/// ## Пример использования:
///
/// Вставьте `RotatingCircles` в ваш SwiftUI View, задайте размер и цвета.
///
/// ```
/// RotatingCircles(size: 80, colors: [.blue, .pink, .green], duration: 2)
/// ```
///
/// - Requires: `SwiftUI`
public struct RotatingCircles: View {
    private var size: CGFloat
    private var colors: [Color]
    private let duration: Double
    
    @State private var isAnimating: Bool = false  // Флаг анимации
    
    /// Инициализатор для создания компонента `RotatingCircles`.
    /// - Parameters:
    ///   - size: Размер компонента.
    ///   - colors: Массив цветов для кругов.
    ///   - duration: Продолжительность анимации в секундах.
    public init(size: CGFloat, colors: [Color], duration: Double) {
        self.size = size
        self.colors = colors
        self.duration = duration
    }
    
    public var body: some View {
        ZStack {
            // Создаем три круга с заданными параметрами
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(self.colors[index % self.colors.count])  // Цикличное использование цветов
                    .frame(width: self.size / 3, height: self.size / 3)  // Размер каждого круга
                    .offset(
                        x: isAnimating ? cos(CGFloat(index) * 2 * .pi / 3) * size / 3 : 0,  // Горизонтальное смещение для анимации
                        y: isAnimating ? sin(CGFloat(index) * 2 * .pi / 3) * size / 3 : 0   // Вертикальное смещение для анимации
                    )
            }
        }
        .frame(width: size, height: size)  // Общий размер композиции кругов
        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))  // Вращение всей композиции
        .onAppear {
            // Запуск анимации при появлении компонента
            withAnimation(Animation.linear(duration: duration / 2).repeatForever(autoreverses: true)) {
                isAnimating = true  // Активация флага анимации
            }
        }
    }
}
