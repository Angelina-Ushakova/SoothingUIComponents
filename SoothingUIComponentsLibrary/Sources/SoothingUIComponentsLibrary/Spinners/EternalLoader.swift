import SwiftUI

/// `EternalLoader` - анимированный индикатор в форме символа бесконечности.
///
/// Анимация бесконечно повторяется, создавая эффект непрерывного движения.
/// Размер, цвет и скорость анимации можно настроить.
///
/// ## Пример использования:
///
/// ```
/// EternalLoader(size: 200, strokeWidth: 20, color: .pink, animationDuration: 0.2)
/// ```
///
/// - Requires: `SwiftUI`
public struct EternalLoader: View {
    let size: CGFloat // Размер индикатора
    let strokeWidth: CGFloat // Толщина линии индикатора
    let color: Color // Цвет индикатора
    let animationDuration: TimeInterval // Длительность анимации

    @State private var strokeStart: CGFloat = 0 // Начало линии обрезки
    @State private var strokeEnd: CGFloat = 0 // Конец линии обрезки
    @State private var additionalLength: CGFloat = 0 // Дополнительная длина для анимации
    
    // Константа для управления анимацией
    private let animationCap: CGFloat = 1.205
    
    // Инициализатор для `EternalLoader`.
    /// - Parameters:
    ///   - size: Размер индикатора.
    ///   - strokeWidth: Толщина линии индикатора.
    ///   - color: Цвет индикатора.
    ///   - animationDuration: Длительность анимации.
    public init(size: CGFloat, strokeWidth: CGFloat, color: Color, animationDuration: TimeInterval) {
        self.size = size * 1.25
        self.strokeWidth = strokeWidth
        self.color = color
        self.animationDuration = animationDuration / 10
    }
    
    public var body: some View {
        ZStack {
            // Фоновая фигура
            EternalShape(size: size)
                .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(color.opacity(0.5))
                .shadow(color: color.opacity(0.5), radius: strokeWidth / 5)
                .overlay(
                    // Анимированная фигура
                    EternalShape(size: size)
                        .trim(from: strokeStart, to: strokeEnd)
                        .stroke(style: StrokeStyle(lineWidth: strokeWidth - 0.5, lineCap: .round, lineJoin: .round))
                        .foregroundColor(color.opacity(0.5))
                        .shadow(color: color, radius: strokeWidth / 3)
                )
        }
        .frame(width: size / 400, height: size / 400)
        .onAppear() {
            // Инициализация и запуск анимации
            Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
                withAnimation(Animation.linear(duration: animationDuration)) {
                    strokeEnd += 0.05
                    strokeStart = strokeEnd - (0.05 + additionalLength)
                }
                
                // Сброс значений при достижении конца анимации
                if (strokeEnd >= animationCap) {
                    strokeEnd = 0
                    additionalLength = 0
                    strokeStart = 0
                }
            }
            
            // Постепенное увеличение длины анимированной линии
            Timer.scheduledTimer(withTimeInterval: animationDuration * 3, repeats: true) { _ in
                additionalLength += 0.015
            }
        }
    }
}

/// `EternalShape` представляет собой форму символа бесконечности для `EternalLoader`.
struct EternalShape: Shape {
    let size: CGFloat // Размер фигуры

    func path(in rect: CGRect) -> Path {
        // Расчетные коэффициенты и точки для создания формы бесконечности
        var path = Path()
        
        let factor = size / 400 // Множитель для масштабирования
        let adjustedMidX = rect.midX * factor
        let adjustedMidY = rect.midY * factor
        
        // Создание кривых для формы бесконечности
        path.move(to: CGPoint(x: adjustedMidX - 100 * factor, y: adjustedMidY + 72 * factor))
        
        // Добавление кривых для полного контура бесконечности
        path.addCurve(to: CGPoint(x: adjustedMidX - 100 * factor, y: adjustedMidY - 72 * factor),
                      control1: CGPoint(x: adjustedMidX - 200 * factor, y: adjustedMidY + 72 * factor),
                      control2: CGPoint(x: adjustedMidX - 200 * factor, y: adjustedMidY - 72 * factor))
        path.addCurve(to: CGPoint(x: adjustedMidX + 100 * factor, y: adjustedMidY + 72 * factor),
                      control1: CGPoint(x: adjustedMidX, y: adjustedMidY - 72 * factor),
                      control2: CGPoint(x: adjustedMidX, y: adjustedMidY + 72 * factor))
        path.addCurve(to: CGPoint(x: adjustedMidX + 100 * factor, y: adjustedMidY - 72 * factor),
                      control1: CGPoint(x: adjustedMidX + 200 * factor, y: adjustedMidY + 72 * factor),
                      control2: CGPoint(x: adjustedMidX + 200 * factor, y: adjustedMidY - 72 * factor))
        path.addCurve(to: CGPoint(x: adjustedMidX - 100 * factor, y: adjustedMidY + 72 * factor),
                      control1: CGPoint(x: adjustedMidX, y: adjustedMidY - 72 * factor),
                      control2: CGPoint(x: adjustedMidX, y: adjustedMidY + 72 * factor))
        return path
    }
}
