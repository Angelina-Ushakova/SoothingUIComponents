import SwiftUI

/// `WaveButton` - это кнопка, создающая волновую анимацию при нажатии.
///
/// При нажатии на кнопку, волна начинает движение от центра к краям, создавая визуальный эффект распространяющейся волны.
/// Эффект достигается за счёт изменения углового смещения и процента заполнения для волны.
///
/// ## Пример использования:
/// 
/// Вставьте `WaveButton` в ваш SwiftUI View и укажите размер, цвет и действие, которое должно выполниться при нажатии.
///
/// ```
/// WaveButton(size: 100, waveColor: .blue, action: {
///     print("Кнопка была нажата.")
/// })
/// ```
/// 
/// - Requires: `SwiftUI`
public struct WaveButton: View {
    /// Размер кнопки в точках.
    let size: CGFloat
    /// Цвет волны, создаваемой при нажатии.
    let waveColor: Color
    /// Действие, выполняемое при нажатии на кнопку.
    let action: () -> Void
    
    /// Угловое смещение волны для создания анимационного эффекта.
    @State private var waveOffset = Angle(degrees: 0)
    /// Процент заполнения волной, отражающий степень заполнения круга волной.
    @State private var percent = 50.0
    
    /// Инициализатор `WaveButton`.
    /// - Parameters:
    ///   - size: Размер кнопки в точках.
    ///   - waveColor: Цвет волны.
    ///   - action: Замыкание, вызываемое при нажатии на кнопку.
    public init(size: CGFloat, waveColor: Color, action: @escaping () -> Void) {
        self.size = size
        self.waveColor = waveColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()  // Вызов пользовательского действия
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)  // Запуск анимации волны
            }
            self.percent = self.percent >= 100 ? 0 : self.percent + 10  // Изменение процента заполнения волной
        }) {
            ZStack {
                Text("\(Int(self.percent))%")  // Отображение процента заполнения в центре кнопки
                    .foregroundColor(waveColor)
                    .font(.system(size: size * 0.3))
                Circle()  // Отрисовка основы кнопки
                    .strokeBorder(waveColor, lineWidth: 2)
                    .frame(width: size, height: size)
                Wave(offset: waveOffset, percent: percent / 100)  // Волновая анимация
                    .fill(waveColor.opacity(0.5))
                    .frame(width: size, height: size)
                    .clipShape(Circle())  // Обрезка волны по форме круга
            }
        }
        .frame(width: size, height: size)  // Установка размера кнопки
    }
}

/// `Wave` - структура, представляющая форму волны внутри `WaveButton`.
///
/// Определяет пользовательскую форму для волны, которая анимируется с помощью углового смещения и процента заполнения.
public struct Wave: Shape {
    /// Угловое смещение для анимации волны.
    var offset: Angle
    /// Процент заполнения волны, определяющий длину волны внутри кнопки.
    var percent: Double

    /// Анимируемые данные, позволяющие волне плавно изменяться при анимации.
    public var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    /// Определяет путь волны, отрисовывая волновую форму внутри кнопки.
    /// - Parameter rect: Прямоугольная область, в которой рисуется волна.
    /// - Returns: Объект `Path`, представляющий форму волны.
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = 0.015 * rect.height  // Высота волны
        let yOffset = CGFloat(1 - percent) * (rect.height - waveHeight)  // Вертикальное смещение волны
        
        // Создание волнового пути
        path.move(to: CGPoint(x: 0, y: yOffset))
        for x in stride(from: 0, to: rect.width, by: 1) {
            let relativeX = x / rect.width
            let sineWaveY = waveHeight * CGFloat(sin(relativeX * 2 * .pi + offset.radians))  // Вычисление Y позиции волны
            path.addLine(to: CGPoint(x: x, y: sineWaveY + yOffset))
        }
        
        // Завершение пути волны, обратно к нижней правой угловой точке
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
