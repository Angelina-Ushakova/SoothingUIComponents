import SwiftUI

/// `WaveButton` - это кнопка, создающая волновую анимацию при нажатии.
///
/// При нажатии на кнопку, волна начинает движение от центра к краям, создавая визуальный эффект распространяющейся волны.
///
/// - Parameters:
///   - size: Размер кнопки в точках.
///   - waveColor: Цвет волны, создаваемой при нажатии.
///   - action: Действие, выполняемое при нажатии на кнопку.
///
/// ## Пример использования:
/// ```
/// WaveButton(size: 100, waveColor: .blue, action: {
///     print("Кнопка была нажата.")
/// })
/// ```
public struct WaveButton: View {
    let size: CGFloat
    let waveColor: Color
    let action: () -> Void
    
    @State private var waveOffset = Angle(degrees: 0)  // Угловое смещение волны
    @State private var percent = 50.0  // Процент заполнения волной
    
    /// Инициализирует кнопку с указанными параметрами.
    public init(size: CGFloat, waveColor: Color, action: @escaping () -> Void) {
        self.size = size
        self.waveColor = waveColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()  // Вызов переданного действия
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)  // Анимация вращения волны
            }
            self.percent = self.percent >= 100 ? 0 : self.percent + 10  // Увеличение процента заполнения
        }) {
            ZStack {
                Text("\(Int(self.percent))%")  // Отображение процента заполнения
                    .foregroundColor(waveColor)
                    .font(.system(size: size * 0.3))
                Circle()  // Основа кнопки
                    .strokeBorder(waveColor, lineWidth: 2)
                    .frame(width: size, height: size)
                Wave(offset: waveOffset, percent: percent / 100)  // Волновая анимация
                    .fill(waveColor.opacity(0.5))
                    .frame(width: size, height: size)
                    .clipShape(Circle())  // Ограничение формы волны кругом
            }
        }
        .frame(width: size, height: size)
    }
}

/// `Wave` - структура, представляющая форму волны внутри `WaveButton`.
///
/// Реализует протокол `Shape`, что позволяет определить пользовательский путь для отображения в SwiftUI.
public struct Wave: Shape {
    var offset: Angle  // Угловое смещение для анимации волны
    var percent: Double  // Процент заполнения волны

    /// Анимируемые данные, позволяющие волне плавно изменяться.
    public var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    /// Определяет как волна будет отрисовываться.
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = 0.015 * rect.height  // Высота волны
        let yOffset = CGFloat(1 - percent) * (rect.height - waveHeight)  // Смещение волны от верхней границы
        
        // Начало пути волны
        path.move(to: CGPoint(x: 0, y: yOffset))
        // Создание волнистой формы
        for x in stride(from: 0, to: rect.width, by: 1) {
            let relativeX = x / rect.width
            let sineWaveY = waveHeight * CGFloat(sin(relativeX * 2 * .pi + offset.radians))
            path.addLine(to: CGPoint(x: x, y: sineWaveY + yOffset))
        }
        // Замыкание пути волны
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
