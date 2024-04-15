import SwiftUI

/// `FaceAnimation` - Визуализирует анимированное лицо с двумя глазами и ртом.
///
/// Это представление используется для отображения лица, где глаза могут анимироваться вращением.
///
/// ## Пример использования:
/// Вставьте `FaceAnimation` в ваш SwiftUI View, задав размер и цвет лица.
///
/// ```
/// FaceAnimation(size: 100, faceColor: .yellow)
/// ```
///
/// - Requires: `SwiftUI`
public struct FaceAnimation: View {
    var size: CGFloat
    var faceColor: Color
    var yOffset: CGFloat

    /// Инициализирует `FaceAnimation` с заданным размером и цветом лица.
    /// - Parameters:
    ///   - size: Размер лица.
    ///   - faceColor: Цвет лица.
    public init(size: CGFloat, faceColor: Color) {
        self.size = size
        self.faceColor = faceColor
        self.yOffset = size <= 50 ? -size / 8 : size / 15
    }
    
    public var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)  // Полностью прозрачный фон
            EyesAndMouth(eyeSize: size / 3, faceColor: faceColor, faceWidth: size, yOffset: yOffset)
        }
    }
}

/// `EyesAndMouth` - Структура для создания глаз и рта внутри лица.
///
/// Отображает два глаза и рот, расположенные на лице согласно заданным параметрам.
private struct EyesAndMouth: View {
    var eyeSize: CGFloat
    var faceColor: Color
    var faceWidth: CGFloat
    var yOffset: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: faceWidth)
                .foregroundColor(faceColor)
            VStack {
                HStack(spacing: faceWidth / 10) {
                    EyeShape(size: eyeSize)
                    EyeShape(size: eyeSize)
                }
                .padding(.top, faceWidth / 15)
                .offset(y: -yOffset / 5)
                Ellipse()  // Рот
                    .frame(width: eyeSize / 2, height: eyeSize / 3)
                    .offset(y: yOffset)
            }
        }
        .frame(width: faceWidth)
    }
}

/// `EyeShape` - Структура для создания глаза с возможностью анимации.
///
/// Глаз включает в себя три слоя: внешний черный круг, белый круг и черный зрачок, который анимируется с вращением.
public struct EyeShape: View {
    var size: CGFloat
    @State private var yOffset: CGFloat = 60
    @State private var animate = false  // Управление анимацией вращения
    
    public var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(.black)  // Внешний край глаза
            Circle()
                .frame(width: size * 0.97)
                .foregroundColor(.white)  // Белок глаза
            Circle()
                .frame(width: size / 3, height: size / 3)
                .foregroundColor(.black)  // Зрачок
                .offset(x: size / 4)  // Смещение зрачка для создания эффекта движения
                .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 0, y: 0, z: 1))  // Вращение зрачка
                .animation(Animation.easeOut(duration: 1.0).repeatForever(autoreverses: false))
                .offset(y: yOffset)
        }
        .onAppear {
            animate.toggle()  // Запуск анимации при появлении
            yOffset -= 60
        }
    }
}
