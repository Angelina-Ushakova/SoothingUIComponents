import SwiftUI

/// `PulsingCapsules` - View, отображающий анимированную последовательность пульсирующих капсул.
///
/// Капсулы пульсируют, увеличиваясь и уменьшаясь в размере в зависимости от их положения в последовательности.
/// Предоставляет возможность настройки количества капсул, размеров, цвета и скорости анимации.
///
/// ## Пример использования:
/// Вставьте `PulsingCapsules` в ваш SwiftUI View, настроив размеры, цвет и количество капсул:
/// ```
/// PulsingCapsules(capsuleWidth: 10, capsuleHeight: 50, color: .red, numberOfCapsules: 5, animationDuration: 0.5)
/// ```
///
/// - Requires: `SwiftUI`
public struct PulsingCapsules: View {
    @State private var indexOfAnimatedCapsule: Int = 0 // Индекс активно анимируемой капсулы
    @State private var decreasing = false // Флаг уменьшения индекса активной капсулы
    private var capsuleWidth: CGFloat // Ширина капсулы
    private var capsuleHeight: CGFloat // Высота капсулы
    private var color: Color // Цвет капсул
    private var numberOfCapsules: Int // Количество капсул
    private var animationDuration: Double // Длительность анимации

    /// Инициализатор для `PulsingCapsules`.
    /// - Parameters:
    ///   - capsuleWidth: Ширина каждой капсулы.
    ///   - capsuleHeight: Высота каждой капсулы.
    ///   - color: Цвет капсул.
    ///   - numberOfCapsules: Количество капсул в последовательности.
    ///   - animationDuration: Длительность анимации увеличения одной капсулы.
    public init(capsuleWidth: CGFloat, capsuleHeight: CGFloat, color: Color, numberOfCapsules: Int, animationDuration: Double) {
        self.capsuleWidth = capsuleWidth
        self.capsuleHeight = capsuleHeight
        self.color = color
        self.numberOfCapsules = numberOfCapsules
        self.animationDuration = animationDuration / 2
    }

    /// Визуальное представление компонента.
    public var body: some View {
        GeometryReader { geo in
            HStack(spacing: capsuleWidth) {
                ForEach(0..<numberOfCapsules, id: \.self) { i in
                    Capsule()
                        .fill(color)
                        .frame(width: capsuleWidth, height: heightForCapsuleAt(i))
                        .animation(.easeOut(duration: animationDuration), value: indexOfAnimatedCapsule)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .onAppear(perform: animateCapsules)
        }
    }

    /// Вычисляет высоту капсулы на определённой позиции.
    /// - Parameter index: Индекс капсулы в массиве.
    /// - Returns: Высота капсулы.
    private func heightForCapsuleAt(_ index: Int) -> CGFloat {
        switch abs(indexOfAnimatedCapsule - index) {
        case 0: return capsuleHeight * 4
        case 1: return capsuleHeight * 3
        case 2: return capsuleHeight * 2
        default: return capsuleHeight
        }
    }

    /// Запускает анимацию пульсирующего движения капсул.
    private func animateCapsules() {
        Timer.scheduledTimer(withTimeInterval: animationDuration / Double(numberOfCapsules - 1), repeats: true) { _ in
            withAnimation(.easeOut(duration: animationDuration)) {
                if indexOfAnimatedCapsule == numberOfCapsules - 1 {
                    decreasing = true
                } else if indexOfAnimatedCapsule == 0 {
                    decreasing = false
                }
                
                indexOfAnimatedCapsule += decreasing ? -1 : 1
            }
        }
    }
}
