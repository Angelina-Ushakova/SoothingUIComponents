import SwiftUI

/// `NavigationBar` представляет собой навигационную панель, отображающую элементы `NavigationBarItem`.
/// Эта панель позволяет пользователю переключаться между различными разделами приложения.
///
/// ## Пример использования:
/// Создайте массив элементов `NavigationBarItem`, затем используйте `NavigationBar` для отображения их в интерфейсе.
///
/// ```
/// NavigationBar(width: 300, height: 50, items: [
///     NavigationBarItem(icon: "house", color: .blue, action: { print("Домой") }),
///     NavigationBarItem(icon: "gear", color: .gray, action: { print("Настройки") })
/// ])
/// ```
///
/// - Requires: `SwiftUI`
public struct NavigationBar: View {
    private var width: CGFloat
    private var height: CGFloat
    private let animation: Animation = .interpolatingSpring(mass: 0.5, stiffness: 100, damping: 6)
    
    private var items: [NavigationBarItem]
    @State private var selectedIndex = 0

    private let paddingRatio: CGFloat = 0.15

    public init(width: CGFloat, height: CGFloat, items: [NavigationBarItem]) {
        self.width = width
        self.height = height
        self.items = items
    }

    public var body: some View {
        let totalPadding = width * paddingRatio
        let individualPadding = totalPadding / CGFloat(items.count + 1)
        let itemWidth = (width - totalPadding - individualPadding * CGFloat(items.count - 1)) / CGFloat(items.count)

        return ZStack {
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: width, height: height)
                .foregroundColor(items[selectedIndex].color)

            HStack(spacing: individualPadding) {
                ForEach(0..<items.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(animation) {
                            selectedIndex = index
                            items[index].action()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: height / 2)
                                .frame(width: selectedIndex == index ? itemWidth * 1.6 : itemWidth, height: height * (1 - paddingRatio))
                                .foregroundColor(.white)
                                .opacity(selectedIndex == index ? 0.3 : 1)

                            Image(systemName: items[index].icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: height * (1 - paddingRatio) / 2, height: height * (1 - paddingRatio) / 2)
                                .foregroundColor(selectedIndex == index ? .white : .gray)
                        }
                    }
                    .animation(animation, value: selectedIndex)
                }
            }
            .padding(.horizontal, individualPadding)
        }
    }
}

/// `NavigationBarItem` представляет элемент навигационной панели, содержащий иконку, цвет и действие, выполняемое при нажатии.
/// Этот элемент используется в `NavigationBar` для создания интерактивного интерфейса.
///
/// - Parameters:
///   - icon: Строка, представляющая системное имя иконки.
///   - color: Цвет элемента навигационной панели.
///   - action: Замыкание, выполняемое при нажатии на элемент.
public struct NavigationBarItem {
    public let icon: String
    public let color: Color
    public let action: () -> Void

    public init(icon: String, color: Color, action: @escaping () -> Void) {
        self.icon = icon
        self.color = color
        self.action = action
    }
}
