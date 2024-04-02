import SwiftUI

/// `RotatingLoader` - вращающийся индикатор загрузки.
///
/// Анимация состоит из двух вращающихся кругов разного размера, которые вращаются с разной скоростью, создавая уникальный визуальный эффект.
///
/// ## Пример использования:
/// Вставьте `RotatingLoader` в ваш SwiftUI View, укажите размеры кругов, цвет и длительность анимации.
///
/// ```
/// RotatingLoader(largeCircleSize: 100, smallCircleSize: 50, color: .blue, animationDuration: 2.0)
/// ```
///
/// - Requires: `SwiftUI`
public struct RotatingLoader: View {
    @State private var largeCircleProgress: CGFloat = 0.001 // Начальное положение анимации для большого круга
    @State private var smallCircleProgress: CGFloat = 1 // Начальное положение анимации для маленького круга
    @State private var largeRotationDegree: Angle = .degrees(-90) // Начальный угол поворота для большого круга
    @State private var smallRotationDegree: Angle = .degrees(-30) // Начальный угол поворота для маленького круга
    
    /// Размер большого круга.
    public var largeCircleSize: CGFloat
    /// Размер маленького круга.
    public var smallCircleSize: CGFloat
    /// Цвет элементов.
    public var color: Color
    /// Длительность анимации в секундах.
    public var animationDuration: Double
    
    /// Инициализатор `RotatingLoader`.
    /// - Parameters:
    ///   - largeCircleSize: Размер большого круга.
    ///   - smallCircleSize: Размер маленького круга.
    ///   - color: Цвет элементов.
    ///   - animationDuration: Длительность анимации.
    public init(largeCircleSize: CGFloat, smallCircleSize: CGFloat, color: Color, animationDuration: Double) {
        self.largeCircleSize = largeCircleSize
        self.smallCircleSize = smallCircleSize
        self.color = color
        self.animationDuration = animationDuration
    }
    
    public var body: some View {
        ZStack {
            // Большой круг
            Circle()
                .trim(from: 0, to: largeCircleProgress)
                .stroke(style: StrokeStyle(lineWidth: largeCircleSize / 9.5, lineCap: .round))
                .fill(color)
                .rotationEffect(largeRotationDegree)
                .frame(width: largeCircleSize, height: largeCircleSize)
            
            // Маленький круг
            Circle()
                .trim(from: 0, to: smallCircleProgress)
                .stroke(style: StrokeStyle(lineWidth: smallCircleSize / 5.5, lineCap: .round))
                .fill(color.opacity(0.8))
                .rotationEffect(smallRotationDegree)
                .frame(width: smallCircleSize, height: smallCircleSize)
        }
        .frame(width: largeCircleSize, height: largeCircleSize)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animate()
                Timer.scheduledTimer(withTimeInterval: animationDuration * 1.98, repeats: true) { _ in
                    reset()
                    animate()
                }
            }
        }
    }
    
    private func animate() {
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            largeCircleProgress = 1
        }
        withAnimation(Animation.easeOut(duration: animationDuration * 1.1)) {
            largeRotationDegree = .degrees(365)
        }
        
        withAnimation(Animation.easeOut(duration: animationDuration * 0.85)) {
            smallCircleProgress = 0.001
            smallRotationDegree = .degrees(679)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 0.7, repeats: false) { _ in
            withAnimation(Animation.easeIn(duration: animationDuration * 0.4)) {
                smallRotationDegree = .degrees(825)
                largeRotationDegree = .degrees(375)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: animationDuration)) {
                largeRotationDegree = .degrees(990)
                largeCircleProgress = 0.001
            }
            
            withAnimation(Animation.linear(duration: animationDuration * 0.8)) {
                smallCircleProgress = 1
                smallRotationDegree = .degrees(990)
            }
        }
    }
    
    private func reset() {
        // Сброс углов вращения к исходному состоянию перед началом нового цикла анимации
        largeRotationDegree = .degrees(-90)
        smallRotationDegree = .degrees(-30)
    }
}
