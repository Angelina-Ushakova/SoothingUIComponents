import SwiftUI

/// `WaveButton` - это кнопка, создающая волновую анимацию при нажатии.
///
/// При нажатии волна начинает движение, создавая визуальный эффект.
///
/// - Parameters:
///   - size: Размер кнопки.
///   - waveColor: Цвет волны.
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
    
    @State private var waveOffset = Angle(degrees: 0)
    @State private var percent = 50.0
    
    // Открытый конструктор для инициализации из внешних модулей.
    public init(size: CGFloat, waveColor: Color, action: @escaping () -> Void) {
        self.size = size
        self.waveColor = waveColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
            self.percent = self.percent >= 100 ? 0 : self.percent + 10
        }) {
            ZStack {
                Text("\(Int(self.percent))%")
                    .foregroundColor(.white)
                    .font(.system(size: size * 0.4))
                Circle()
                    .strokeBorder(waveColor, lineWidth: 2)
                    .frame(width: size, height: size)
                Wave(offset: waveOffset, percent: percent / 100)
                    .fill(waveColor.opacity(0.5))
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            }
        }
        .frame(width: size, height: size)
    }
}


/// `Wave` - структура, представляющая форму волны внутри `CircleWaveButton`.
///
/// Структура `Wave` реализует протокол `Shape`, что позволяет ей определять пользовательский путь для отображения в SwiftUI.
public struct Wave: Shape {
    var offset: Angle
    var percent: Double
    
    public var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight = 0.015 * rect.height
        let yOffset = CGFloat(1 - percent) * (rect.height - waveHeight)
        
        path.move(to: CGPoint(x: 0, y: yOffset))
        for x in stride(from: 0, to: rect.width, by: 1) {
            let relativeX = x / rect.width
            let sineWaveY = waveHeight * CGFloat(sin(relativeX * 2 * .pi + offset.radians))
            path.addLine(to: CGPoint(x: x, y: sineWaveY + yOffset))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
