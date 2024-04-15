import SwiftUI

/// `FluidLoadingButton` - кнопка, демонстрирующая анимацию загрузки с эффектом наливания жидкости.
///
/// Эта кнопка анимирует заполнение контура капсулы жидкостью, создавая эффект процесса загрузки.
///
/// ## Пример использования:
/// Вставьте `FluidLoadingButton` в ваш SwiftUI View, укажите высоту кнопки, скорость движения жидкости, высоту волны, градиент переднего фона и цвет фона.
///
/// ```
/// FluidLoadingButton(height: 350, fluidSpeed: 1.5, waveHeight: 20, foregroundColor: LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .top, endPoint: .bottom), backgroundColor: .purple)
/// ```
///
/// - Requires: `SwiftUI`
public struct FluidLoadingButton: View {
    @State private var time: Double = 0 // Управляет временем для анимации волн
    @State private var animate = false // Состояние анимации
    @State private var offsetY: CGFloat = 0 // Вертикальное смещение для эффекта жидкости
    @State private var timer: Timer? // Таймер для управления анимацией
    @State private var isFilled = false // Показывает, заполнена ли кнопка
    @State private var showLoadingText = false // Управление видимостью текста загрузки

    private var height: CGFloat
    private var fluidSpeed: CGFloat
    private var waveHeight: CGFloat
    private var foregroundColor: LinearGradient
    private var backgroundColor: Color

    /// Инициализатор `FluidLoadingButton`.
    /// - Parameters:
    ///   - height: Высота кнопки.
    ///   - fluidSpeed: Скорость движения жидкости вверх.
    ///   - waveHeight: Высота волны жидкости.
    ///   - foregroundColor: Градиентный цвет переднего плана жидкости.
    ///   - backgroundColor: Цвет фона кнопки.
    public init(height: CGFloat, fluidSpeed: CGFloat, waveHeight: CGFloat, foregroundColor: LinearGradient, backgroundColor: Color) {
        self.height = height
        self.fluidSpeed = fluidSpeed
        self.waveHeight = waveHeight
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        Button(action: resetLoading) {
            VStack {
                ZStack {
                    // Фон капсулы
                    Capsule()
                        .frame(width: height / 3, height: height)
                        .foregroundColor(.white)
                        .shadow(radius: height / 50)
                    
                    // Волны анимации жидкости
                    ZStack {
                        CapsuleFluid(time: CGFloat(time * 1.2), curveHeight: waveHeight, height: height)
                            .fill(backgroundColor)
                            .opacity(0.4)
                            .frame(width: height / 3, height: height)
                        CapsuleFluid(time: CGFloat(time), curveHeight: waveHeight, height: height)
                            .fill(foregroundColor)
                            .opacity(0.2)
                            .frame(width: height / 3, height: height)
                    }
                    .offset(x: 0, y: self.offsetY)
                    .mask(Capsule())
                    
                    // Отображение процента заполнения
                    if isFilled {
                        Text("100%")
                            .bold()
                            .foregroundColor(backgroundColor)
                            .font(.system(size: height / 10))
                    }
                }
                .padding(.bottom, height / 30)
                
                // Текст "Loading..."
                Text("Loading...")
                    .italic()
                    .bold()
                    .font(.system(size: height / 15))
                    .foregroundColor(backgroundColor)
                    .opacity(showLoadingText ? 1 : 0)
            }
        }
    }

    private func resetLoading() {
        // Сброс и перезапуск анимации
        if isFilled {
            isFilled = false
        }
        offsetY = (height / 2) + waveHeight
        startAnimation()
    }

    private func startAnimation() {
        // Инициализация анимации заполнения
        showLoadingText = true
        timer?.invalidate()
        offsetY = (height / 2) + waveHeight
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { tempTimer in
            withAnimation(Animation.linear(duration: 0.03)) {
                self.time += 0.01
                self.offsetY -= fluidSpeed
                if self.offsetY <= ((-self.height / 2) - waveHeight) {
                    self.offsetY = (-self.height / 2) - waveHeight
                    self.isFilled = true
                    tempTimer.invalidate()
                    showLoadingText = false
                }
            }
        }
    }
}

/// `CapsuleFluid` - форма для создания анимированной волны в `FluidLoadingButton`.
struct CapsuleFluid: Shape {
    var time: CGFloat
    var curveHeight: CGFloat
    var height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: height, y: height))
            path.addLine(to: CGPoint(x: 0, y: 1000))
            for i in stride(from: 0, to: CGFloat(rect.width * 3), by: 1) {
                path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + time) * 4 * .pi) * curveHeight + rect.midY))
            }
            path.addLine(to: CGPoint(x: height, y: height))
        }
    }
}
