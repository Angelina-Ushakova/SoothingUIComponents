import SwiftUI

/// `HarmonySpinner` - анимированный спиннер, который плавно вращается и меняет цвета, создавая гармоничный визуальный эффект.
///
/// Спиннер состоит из нескольких сегментов, каждый из которых окрашен в свой цвет из заданного массива.
/// Во время анимации каждый сегмент спиннера плавно увеличивается и сокращается, создавая эффект вращения.
///
/// ## Пример использования:
///
/// Вставьте `HarmonySpinner` в ваш SwiftUI View, укажите время вращения, размер и массив цветов для спиннера.
///
/// ```
/// HarmonySpinner(rotationTime: 2.0, size: 200, colors: [.red, .blue, .green])
/// ```
///
/// - Requires: `SwiftUI`
public struct HarmonySpinner: View {
    /// Время, необходимое для одного полного оборота спиннера.
    private var rotationTime: Double
    /// Размер спиннера.
    private var size: CGFloat
    /// Массив цветов для сегментов спиннера.
    private var colors: [Color]
    
    /// Инициализатор `HarmonySpinner`.
    /// - Parameters:
    ///   - rotationTime: Время одного полного оборота спиннера.
    ///   - size: Диаметр спиннера.
    ///   - colors: Массив цветов, которые будут использоваться в спиннере.
    public init(rotationTime: Double, size: CGFloat, colors: [Color]) {
        self.rotationTime = rotationTime
        self.size = size
        self.colors = colors
    }

    @State private var rotationDegrees = Angle(degrees: 270)
    @State private var spinnerEnds = 0.03
    @State private var yOffset: CGFloat = 60  // Начальное смещение спиннера

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<colors.count, id: \.self) { index in
                    SpinnerCircle(start: 0.0, end: spinnerEnds, rotation: rotationDegrees + .degrees(120.0 * Double(index)), color: colors[index], size: size)
                        .frame(width: size, height: size)
                        .offset(y: yOffset)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear() {
                animateSpinner()
            }
        }
    }

    private func animateSpinner() {
        // Анимация, которая вызывает вращение и изменение размера спиннера
        withAnimation(Animation.easeInOut(duration: rotationTime).repeatForever(autoreverses: true)) {
            spinnerEnds = 1.0  // Полное расширение спиннера
            rotationDegrees += .degrees(360)  // Полный оборот
            yOffset -= 60  // Коррекция смещения для поддержания стабильного положения спиннера
        }
    }
}

/// `SpinnerCircle` - структура, описывающая отдельный сегмент спиннера.
/// Каждый сегмент представляет собой дугу окружности, которая анимированно изменяет свои размеры и поворачивается.
///
/// - Parameters:
///   - start: Начальная точка дуги окружности.
///   - end: Конечная точка дуги окружности.
///   - rotation: Угол поворота дуги.
///   - color: Цвет дуги.
///   - size: Толщина линии дуги.
struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    var size: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Circle()
                .trim(from: start, to: end)
                .stroke(color, style: StrokeStyle(lineWidth: size / 10 * end, lineCap: .round))
                .rotationEffect(rotation, anchor: .center)
        }
    }
}
