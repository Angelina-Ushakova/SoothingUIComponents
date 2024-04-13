import SwiftUI

/// `GhostLoader` - анимированная форма призрака, используемая для загрузки или ожидания.
///
/// Анимация создает эффект "плывущего" призрака, что делает ожидание более интересным.
///
/// ## Пример использования:
///
/// Вставьте `GhostLoader` в ваш SwiftUI View и укажите размер призрака и цвет.
///
/// ```
/// GhostLoader(ghostSize: 220, ghostColor: .blue)
/// ```
///
/// - Requires: `SwiftUI`
public struct GhostLoader: View {
    @State private var time: Double = 0 // Время для анимации движения волны
    @State private var offset: CGFloat = 0 // Смещение для вертикального движения призрака
    
    public var ghostSize: CGFloat
    public var ghostCurveHeight: CGFloat
    public var ghostCurveLength: CGFloat
    public var ghostColor: Color

    /// Инициализатор `GhostLoader`.
    /// - Parameters:
    ///   - ghostSize: Размер призрака в точках.
    ///   - ghostColor: Цвет призрака.
    public init(ghostSize: CGFloat, ghostColor: Color) {
        self.ghostColor = ghostColor
        self.ghostSize = ghostSize
        self.ghostCurveHeight = ghostSize * 0.06
        self.ghostCurveLength = ghostSize / (ghostSize * 0.05)
    }
    
    public var body: some View {
        ZStack {
            // Фон и основная форма призрака
            Ghost(time: CGFloat(time), width: ghostSize * 1.05, height: ghostSize * 2.5 * 1.05, curveHeight: ghostCurveHeight, curveLength: ghostCurveLength)
                .fill(Color.black)
                .mask(Capsule().frame(width: ghostSize * 1.05, height: ghostSize * 2.5 * 1.044))
                .offset(x: 0, y: ghostSize / 2 * 1.05)
            
            Ghost(time: CGFloat(time), width: ghostSize, height: ghostSize * 2.5, curveHeight: ghostCurveHeight, curveLength: ghostCurveLength)
                .fill(ghostColor)
                .mask(Capsule().frame(width: ghostSize, height: ghostSize * 2.5))
                .offset(x: 0, y: ghostSize / 2)

            // Глаза и рот призрака
            GhostFeatures(ghostSize: ghostSize)
        }
        .offset(y: offset)
        .frame(width: ghostSize * 10, height: ghostSize * 10)
        .onAppear {
            animate()
        }
    }
    
    private func animate() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            self.time += 0.0015 // Обновление времени для анимации
        }
        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            offset += ghostSize / 50 // Вертикальное движение призрака
        }
    }
}

/// `Ghost` - форма призрака с изменяемым волновым контуром.
struct Ghost: Shape {
    var time: CGFloat
    let width: CGFloat
    let height: CGFloat
    let curveHeight: CGFloat
    let curveLength: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            for i in stride(from: 0, to: CGFloat(rect.width), by: 1) {
                path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + time) * curveLength * .pi) * curveHeight + rect.midY))
            }
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }
    }
}

/// `GhostFeatures` - компоненты лица для `GhostLoader`.
struct GhostFeatures: View {
    var ghostSize: CGFloat
    
    var body: some View {
        Group {
            Eye(isRight: false, ghostSize: ghostSize)
            Eye(isRight: true, ghostSize: ghostSize)
            Mouth(ghostSize: ghostSize)
        }
    }
}

/// `Eye` - структура для отображения глаза призрака.
struct Eye: View {
    var isRight: Bool
    var ghostSize: CGFloat
    
    var body: some View {
        Group {
            Circle() // Обводка глаза
                .frame(width: ghostSize / 6, height: ghostSize / 6)
                .offset(x: isRight ? ghostSize / 3.75 : 0, y: -(ghostSize / 3))
            Circle() // Глаз
                .frame(width: ghostSize / 7, height: ghostSize / 7)
                .offset(x: isRight ? ghostSize / 3.75 : 0, y: -(ghostSize / 3))
                .foregroundColor(.white)
            Circle() // Зрачок
                .frame(width: ghostSize / 15, height: ghostSize / 15)
                .offset(x: isRight ? ghostSize / 3.8 : ghostSize * 0.01, y: -(ghostSize / 3))
                .foregroundColor(.black)
        }
    }
}

/// `Mouth` - структура для отображения рта призрака.
struct Mouth: View {
    var ghostSize: CGFloat
    
    var body: some View {
        Ellipse() // Рот
            .frame(width: ghostSize / 7.5, height: ghostSize / 11)
            .offset(x: ghostSize / 6, y: -(ghostSize / 7.5))
    }
}
