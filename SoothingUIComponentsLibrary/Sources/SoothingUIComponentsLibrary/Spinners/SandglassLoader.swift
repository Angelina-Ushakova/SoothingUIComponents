import SwiftUI

/// `SandglassLoader` - анимированный песочный час, который переворачивается и заполняется песком.
///
/// Эта анимация демонстрирует плавное перетекание песка из верхней части в нижнюю и вращение песочных часов.
///
/// ## Пример использования:
/// Вставьте `SandglassLoader` в ваш SwiftUI View, укажите размер, цвета рамки и песка, а также длительность анимации.
///
/// ```
/// SandglassLoader(size: 200, frameColor: .brown, sandColor: .yellow, animationDuration: 2.0)
/// ```
///
/// - Requires: `SwiftUI`
public struct SandglassLoader: View {
    /// Размер песочных часов.
    public var size: CGFloat
    /// Цвет рамки песочных часов.
    public var frameColor: Color
    /// Цвет песка.
    public var sandColor: Color
    /// Длительность одного цикла анимации.
    public var animationDuration: Double
    
    /// Оффсет песка в верхней части песочных часов.
    @State private var topSandOffset: CGFloat = 0
    /// Оффсет песка в центре песочных часов.
    @State private var centerSandOffset: CGFloat = 0
    /// Оффсет песка в нижней части песочных часов.
    @State private var bottomSandOffset: CGFloat = 0
    /// Угол поворота песочных часов.
    @State private var rotationAngle: Double = 0
    
    /// Инициализатор для `SandglassLoader`.
    /// - Parameters:
    ///   - size: Размер песочных часов. Определяет ширину и высоту компонента.
    ///   - frameColor: Цвет рамки песочных часов.
    ///   - sandColor: Цвет песка внутри песочных часов.
    ///   - animationDuration: Длительность одного полного цикла анимации (перетекание песка и поворот).
    public init(size: CGFloat, frameColor: Color, sandColor: Color, animationDuration: Double) {
        self.size = size
        self.frameColor = frameColor
        self.sandColor = sandColor
        self.animationDuration = animationDuration
    }
    
    
    public var body: some View {
        ZStack {
            ZStack {
                // Верхняя часть песка в песочных часах
                Rectangle()
                    .frame(width: size, height: size / 2)
                    .foregroundColor(sandColor)
                    .offset(y: topSandOffset) // Позиция верхнего песка анимируется
                    .mask(Rectangle().frame(width: size, height: size / 2)) // Маска для формы верхнего песка
                    .offset(y: -size / 4 - size * 0.03)
                
                // Центральная перетекающая часть песка
                Rectangle()
                    .frame(width: size * 0.07, height: size / 2)
                    .foregroundColor(sandColor)
                    .offset(y: centerSandOffset) // Позиция центрального песка анимируется
                
                // Нижняя часть песка в песочных часах
                Rectangle()
                    .frame(width: size, height: size / 2)
                    .foregroundColor(sandColor)
                    .offset(y: bottomSandOffset) // Позиция нижнего песка анимируется
                    .mask(Rectangle().frame(width: size, height: size / 2)) // Маска для формы нижнего песка
                    .offset(y: size / 4 + size * 0.03)
            }
            .mask(SandglassShape().frame(width: size * 0.8, height: size)) // Форма песочных часов для маскировки
            
            // Обводка песочных часов
            SandglassShape()
                .stroke(frameColor, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: size * 0.8, height: size)
        }
        .rotationEffect(.degrees(rotationAngle)) // Вращение песочных часов
        .onAppear {
            bottomSandOffset = size / 2
            centerSandOffset = -size / 4 - size * 0.03
            runAnimationContinuously() // Начало анимации при появлении
        }
    }
    
    private func runAnimationContinuously() {
        animateSandglass() // Запуск анимации песочных часов
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.8, repeats: true) { _ in
            animateSandglass() // Повторение анимации с заданным интервалом
        }
    }
    
    private func animateSandglass() {
        // Основной блок анимации песка в верхней и нижней части песочных часов.
        withAnimation(Animation.linear(duration: animationDuration * 0.15)) {
            // Центральный песок начинает движение вниз при начале анимации.
            centerSandOffset = (size / 4) - size * 0.03
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 0.95) {
            withAnimation(Animation.linear(duration: animationDuration * 0.25)) {
                // Завершение движения центрального песка вниз.
                centerSandOffset += (size / 4)
            }
        }
        withAnimation(Animation.linear(duration: animationDuration)) {
            // Песок в верхней части полностью перетекает вниз.
            topSandOffset = size / 2
        }
        withAnimation(Animation.linear(duration: animationDuration).delay(animationDuration * 0.15)) {
            // После короткой задержки начинается перетекание песка из нижней части.
            bottomSandOffset = 0
        }
        
        // Блок анимации для вращения песочных часов.
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 1.3) {
            withAnimation(Animation.easeInOut(duration: animationDuration * 0.3)) {
                // Песочные часы вращаются на 180 градусов.
                rotationAngle = 180
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 0.3) {
                // Сброс угла поворота и позиций песка для начала нового цикла анимации.
                rotationAngle = 0
                topSandOffset = 0
                bottomSandOffset = size / 2
                centerSandOffset = -size / 4 - size * 0.03
            }
        }
    }
}

/// `SandglassShape` - форма песочных часов для маскирования и обводки в `SandglassLoader`.
struct SandglassShape: Shape {
    func path(in rect: CGRect) -> Path {
        // Определение ключевых точек для создания формы песочных часов
        let midTopY = rect.midY - (rect.maxY * 0.05) // Верхняя средняя точка
        let midBotY = rect.midY + (rect.maxY * 0.05) // Нижняя средняя точка
        
        let midLeftX = rect.midX - (rect.maxY * 0.05) // Средняя левая точка
        let midRightX = rect.midX + (rect.maxY * 0.05) // Средняя правая точка
        
        var path = Path()
        
        let radius: CGFloat = rect.maxY / 15 // Радиус закругления углов
        // Вычисление дистанции для создания закругленных углов
        let cornerDistance = sqrt(((sqrt((radius * radius) + (radius * radius)) - radius) * (sqrt((radius * radius) + (radius * radius)) - radius)) / 2)
        
        // Точки для старта и изгиба верхней правой части
        let topRightStart = CGPoint(x: rect.maxX - radius, y: rect.minY)
        let topRightCurve = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
        
        // Точки для старта и изгиба нижней правой части
        let bottomRightStart = CGPoint(x: rect.maxX - cornerDistance, y: rect.maxY - radius - (radius - cornerDistance))
        let bottomRightCurve = CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
        
        // Точки для старта и изгиба нижней левой части
        let bottomLeftStart = CGPoint(x: rect.minX + radius, y: rect.maxY)
        let bottomLeftCurve = CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
        
        // Точки для старта и изгиба верхней левой части
        let topLeftStart = CGPoint(x: rect.minX + cornerDistance, y: rect.minY + radius + (radius - cornerDistance))
        let topLeftCurve = CGPoint(x: rect.minX + radius, y: rect.minY + radius)
        
        // Создание пути, используя определенные точки и добавление дуг и линий
        path.move(to: topRightStart)
        path.addRelativeArc(center: topRightCurve, radius: radius, startAngle: Angle.degrees(270), delta: Angle.degrees(135))
        path.addLine(to: CGPoint(x: midRightX, y: midTopY))
        path.addLine(to: CGPoint(x: midRightX, y: midBotY))
        path.addLine(to: bottomRightStart)
        path.addRelativeArc(center: bottomRightCurve, radius: radius, startAngle: Angle.degrees(315), delta: Angle.degrees(135))
        path.addLine(to: bottomLeftStart)
        path.addRelativeArc(center: bottomLeftCurve, radius: radius, startAngle: Angle.degrees(90), delta: Angle.degrees(135))
        path.addLine(to: CGPoint(x: midLeftX, y: midBotY))
        path.addLine(to: CGPoint(x: midLeftX, y: midTopY))
        path.addLine(to: topLeftStart)
        path.addRelativeArc(center: topLeftCurve, radius: radius, startAngle: Angle.degrees(135), delta: Angle.degrees(135))
        path.closeSubpath()
        
        return path
    }
}
