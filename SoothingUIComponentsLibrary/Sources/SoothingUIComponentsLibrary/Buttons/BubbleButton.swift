import SwiftUI

/// `BubbleButton` - интерактивная кнопка в виде пузырька с реалистичным бликом, который лопается при нажатии.
///
/// При нажатии пузырёк увеличивается и становится полностью прозрачным, создавая эффект лопания, после чего появляется снова.
///
/// ## Пример использования:
///
/// Вставьте `BubbleButton` в ваш SwiftUI View, укажите размер, цвет и действие, которое должно выполниться при нажатии.
///
/// ```
/// BubbleButton(size: 100, color: .blue, action: {
///     print("Пузырь лопнул и появился снова!")
/// })
/// ```
///
/// - Requires: `SwiftUI`
public struct BubbleButton: View {
    /// Размер пузырька в точках.
    private var size: CGFloat
    /// Цвет пузырька.
    private var color: Color
    /// Замыкание, выполняемое при нажатии на пузырь.
    private var action: () -> Void
    
    /// Состояния для управления анимацией пузырька.
    @State private var isPopped = false // Флаг состояния "лопнул ли пузырь"
    @State private var isVisible = true // Флаг видимости пузырька

    /// Инициализатор для создания пузырька.
    /// - Parameters:
    ///   - size: Размер пузырька в точках.
    ///   - color: Цвет пузырька.
    ///   - action: Замыкание, выполняемое при нажатии на пузырь.
    public init(size: CGFloat, color: Color, action: @escaping () -> Void) {
        self.size = size
        self.color = color
        self.action = action
    }

    public var body: some View {
        Button(action: bubblePopAction) {
            GeometryReader { geometry in
                ZStack {
                    if isVisible {
                        // Основной круг пузырька с градиентной заливкой
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.3)]), center: .center, startRadius: 0, endRadius: size / 2))
                            .frame(width: size, height: size)
                            .overlay(
                                // Контур пузырька
                                Circle()
                                    .stroke(color, lineWidth: 4)
                                    .scaleEffect(isPopped ? 1.2 : 1)
                                    .opacity(isPopped ? 0 : 1)
                            )
                            .overlay(
                                // Блик на пузырьке для добавления реализма
                                Group {
                                    Circle()
                                        .fill(Color.white.opacity(0.5))
                                        .frame(width: size / 14, height: size / 14)
                                        .offset(x: -size / 3, y: -size / 5)
                                    Ellipse()
                                        .fill(Color.white.opacity(0.8))
                                        .frame(width: size / 10, height: size / 5)
                                        .offset(x: -size / 2.5, y: -size / 10)
                                        .rotationEffect(Angle(degrees: 40))
                                }
                                .blendMode(.softLight)
                            )
                            .scaleEffect(isPopped ? 1.2 : 1) // Эффект увеличения при лопании
                            .opacity(isPopped ? 0 : 1) // Плавное исчезновение при лопании
                            .animation(.easeOut(duration: 0.5), value: isPopped) // Анимация лопания
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .frame(width: size, height: size) // Устанавливаем размер кнопки с пузырьком
    }

    /// Действие лопания пузырька при нажатии.
    private func bubblePopAction() {
        isPopped = true

        // Задержка перед сокрытием пузырька, имитирующая эффект лопания
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isVisible = false
            action() // Вызов переданного действия

            // Задержка перед восстановлением пузырька
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPopped = false
                isVisible = true
            }
        }
    }
}
