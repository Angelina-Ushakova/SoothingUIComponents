import SwiftUI

/// `AnimatedGradientCircles` - представление, состоящее из анимированных перекрывающихся кругов с градиентной заливкой.
///
/// Эти круги анимируются с изменениями масштаба, вращением и вертикальным перемещением. Это создает живой и динамичный визуальный эффект.
///
/// ## Пример использования:
/// Вставьте `AnimatedGradientCircles` в ваш SwiftUI View, задав размер, градиент, и скорость анимации.
///
/// ```
/// AnimatedGradientCircles(size: 120, primaryColor: .green, secondaryColor: .blue, animationSpeed: 0.08)
/// ```
///
/// - Requires: `SwiftUI`
public struct AnimatedGradientCircles: View {
    /// Размер кругов в точках.
    public var size: CGFloat
    /// Первичный цвет градиента.
    public var primaryColor: Color
    /// Вторичный цвет градиента.
    public var secondaryColor: Color
    /// Скорость анимации.
    public var animationSpeed: Double
    
    @State private var isAnimating = false  // Управление состоянием анимации
    
    /// Инициализатор `AnimatedGradientCircles`.
    /// - Parameters:
    ///   - size: Размер каждого круга.
    ///   - primaryColor: Основной цвет градиента.
    ///   - secondaryColor: Вторичный цвет градиента.
    ///   - animationSpeed: Скорость анимации вращения.
    public init(size: CGFloat, primaryColor: Color, secondaryColor: Color, animationSpeed: Double) {
        self.size = size / 2
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.animationSpeed = animationSpeed / 20
    }
    
    /// Визуальное представление компонента.
    public var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)  // Прозрачный фон для полной видимости
            ZStack {
                Group {
                    // Создание трех пар кругов с разными начальными углами вращения
                    GradientCirclePair(size: size, primaryColor: primaryColor, secondaryColor: secondaryColor, rotationDegrees: 0, isAnimating: $isAnimating)
                    GradientCirclePair(size: size, primaryColor: secondaryColor, secondaryColor: primaryColor, rotationDegrees: 60, isAnimating: $isAnimating)
                    GradientCirclePair(size: size, primaryColor: primaryColor, secondaryColor: secondaryColor, rotationDegrees: 120, isAnimating: $isAnimating)
                }
                .rotationEffect(.degrees(isAnimating ? 90 : 0))
                .scaleEffect(isAnimating ? 1 : 0.45)
                .animation(Animation.easeInOut.repeatForever(autoreverses: true).speed(animationSpeed), value: isAnimating)
                .onAppear {
                    isAnimating.toggle()
                }
            }
        }
    }
}

/// `GradientCirclePair` - Вспомогательная структура для отображения пары градиентных кругов.
///
/// Каждая пара кругов вращается и смещается вертикально, создавая анимацию переливания цветов.
private struct GradientCirclePair: View {
    var size: CGFloat
    var primaryColor: Color
    var secondaryColor: Color
    var rotationDegrees: Double
    @Binding var isAnimating: Bool
    
    var body: some View {
        ZStack {
            // Верхний круг с градиентной заливкой
            Circle().fill(LinearGradient(gradient: Gradient(colors: [primaryColor, primaryColor.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
                .frame(width: size, height: size)
                .offset(y: isAnimating ? -size/2 : 0)
            
            // Нижний круг с градиентной заливкой
            Circle().fill(LinearGradient(gradient: Gradient(colors: [secondaryColor, secondaryColor.opacity(0.3)]), startPoint: .bottom, endPoint: .top))
                .frame(width: size, height: size)
                .offset(y: isAnimating ? size/2 : 0)
        }
        .opacity(0.7)
        .rotationEffect(.degrees(rotationDegrees))  // Вращение пары кругов
    }
}
