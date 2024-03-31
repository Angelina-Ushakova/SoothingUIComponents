import SwiftUI

/// `LikeButton` - кнопка "Нравится", которая анимируется и увеличивает счётчик лайков.
///
/// При нажатии на кнопку, сердце анимированно увеличивается и изменяет цвет, а при отжатии возвращается к исходному размеру и цвету.
/// После нажатия выполняется заданное действие.
///
/// ## Пример использования:
/// Вставьте `LikeButton` в ваш SwiftUI View, укажите начальное количество лайков, размер, цвета и действие.
///
/// ```
/// LikeButton(initialLikes: 3, size: 50, activeColor: .red, inactiveColor: .gray, action: {
///     print("Лайк поставлен!")
/// })
/// ```
///
/// - Requires: `SwiftUI`
public struct LikeButton: View {
    /// Начальное количество лайков.
    private var initialLikes: Int
    /// Размер кнопки.
    private var size: CGFloat
    /// Цвет кнопки в активном состоянии.
    private var activeColor: Color
    /// Цвет кнопки в неактивном состоянии.
    private var inactiveColor: Color
    /// Действие, выполняемое при нажатии.
    private var action: () -> Void

    /// Флаг, указывающий на то, поставлен ли лайк.
    @State private var isLiked = false
    /// Текущее количество лайков.
    @State private var likes: Int
    /// Коэффициент масштабирования сердца.
    @State private var scaleAmount = 0.7

    /// Инициализатор для `LikeButton`.
    /// - Parameters:
    ///   - initialLikes: Начальное количество лайков.
    ///   - size: Размер кнопки.
    ///   - activeColor: Цвет кнопки в активном состоянии.
    ///   - inactiveColor: Цвет кнопки в неактивном состоянии.
    ///   - action: Действие, выполняемое при нажатии.
    public init(initialLikes: Int, size: CGFloat, activeColor: Color, inactiveColor: Color, action: @escaping () -> Void) {
        self.initialLikes = initialLikes
        self.size = size
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.action = action
        _likes = State(initialValue: initialLikes)
    }

    public var body: some View {
        HStack(spacing: size * 0.2) { // Расстояние между сердцем и счётчиком зависит от размера
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(isLiked ? activeColor : inactiveColor)
                .scaleEffect(scaleAmount)
                .animation(isLiked ? .spring(response: 0.3, dampingFraction: 0.6) : .easeInOut(duration: 0.2), value: scaleAmount)
                .onTapGesture {
                    isLiked.toggle()
                    scaleAmount = isLiked ? 1.1 : 0.7 // Эффект "pop" при нажатии и уменьшение при отжатии
                    incrementLikes()
                    action()
                }

            Text("\(likes)")
                .font(.system(size: size / 2, weight: .light))
                .foregroundColor(inactiveColor)
        }
        .padding(.horizontal)
    }

    private func incrementLikes() {
        likes = isLiked ? initialLikes + 1 : initialLikes

        // Задержка для возврата к исходному размеру
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if isLiked {
                scaleAmount = 1.0
            }
        }
    }
}
