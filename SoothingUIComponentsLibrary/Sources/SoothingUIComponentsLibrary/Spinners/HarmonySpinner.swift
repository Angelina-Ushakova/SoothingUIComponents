import SwiftUI

/// `HarmonySpinner` представляет собой анимированный спиннер, который вращается и меняет цвета, создавая эффект гармонии.
///
/// Спиннер состоит из нескольких сегментов, каждый из которых окрашивается в свой цвет из предоставленного массива.
/// Анимация спиннера включает в себя вращение и изменение заполнения сегментов.
///
/// - Parameters:
///   - rotationTime: Время одного полного вращения спиннера в секундах.
///   - size: Диаметр спиннера.
///   - colors: Массив цветов, которые будут использоваться для окрашивания сегментов спиннера.
public struct HarmonySpinner: View {
    var rotationTime: Double
    var size: CGFloat
    var colors: [Color]

    public init(rotationTime: Double, size: CGFloat, colors: [Color]) {
        self.rotationTime = rotationTime
        self.size = size
        self.colors = colors
    }

    @State private var rotationDegrees = Angle(degrees: 270)
    @State private var spinnerEnds = 0.03
    @State private var yOffset: CGFloat = 60 // Начальное смещение спиннера

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

    /// Запускает анимацию спиннера, постепенно увеличивая его заполнение и вращая вокруг своей оси.
    private func animateSpinner() {
        withAnimation(Animation.easeInOut(duration: rotationTime).repeatForever(autoreverses: true)) {
            spinnerEnds = 1.0
            rotationDegrees += .degrees(360)
            yOffset -= 60 // Коррекция смещения для поддержания стабильного положения спиннера
        }
    }
}

/// `SpinnerCircle` отрисовывает отдельный сегмент спиннера.
///
/// - Parameters:
///   - start: Начальная точка сегмента (от 0 до 1).
///   - end: Конечная точка сегмента (от 0 до 1).
///   - rotation: Угол вращения сегмента.
///   - color: Цвет сегмента.
///   - size: Размер штриха сегмента.
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
