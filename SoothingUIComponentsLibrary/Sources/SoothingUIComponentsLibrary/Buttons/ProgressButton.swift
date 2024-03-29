//
//  ProgressButton.swift
//
//
import SwiftUI

/// `ProgressButton` - интерактивная кнопка, предоставляющая визуальный отклик на продолжительные операции.
///
/// При нажатии на кнопку, круговой индикатор начинает заполняться, представляя прогресс выполнения.
/// По завершении прогресса, в центре кнопки появляется галочка и срабатывает заданное пользовательское действие.
///
/// ## Пример использования:
///
/// Вставьте `ProgressButton` в ваш SwiftUI View и укажите длительность анимации, размер, цвет и действие, которое должно выполниться по завершении.
///
/// ```
/// ProgressButton(duration: 1.0, size: 100, color: .blue, action: {
///     print("Задача завершена!")
/// })
/// ```
///
/// - Requires: `SwiftUI`
public struct ProgressButton: View {
    /// Продолжительность анимации индикатора прогресса в секундах.
    private var duration: TimeInterval
    /// Размер кнопки в точках.
    private var size: CGFloat
    /// Цвет индикатора прогресса и текста.
    private var color: Color
    /// Замыкание, выполняемое по завершении анимации прогресса.
    private var action: () -> Void
    
    /// Текущее значение прогресса, представленное от 0 до 1.
    @State private var progress: CGFloat = 0.0
    /// Текстовое представление текущего прогресса в процентах.
    @State private var progressText: String = "0%"
    /// Флаг показа галочки по завершении прогресса.
    @State private var showCheckmark: Bool = false
    /// Таймер, управляющий анимацией прогресса.
    @State private var timer: Timer?
    
    /// Инициализатор `ProgressButton`.
    /// - Parameters:
    ///   - duration: Длительность анимации прогресса в секундах.
    ///   - size: Размер кнопки в точках.
    ///   - color: Цвет элементов кнопки.
    ///   - action: Замыкание, вызываемое по завершении прогресса.
    public init(duration: TimeInterval, size: CGFloat, color: Color, action: @escaping () -> Void) {
        self.duration = duration
        self.size = size
        self.color = color
        self.action = action
    }
    
    /// Тело `ProgressButton`, содержащее описание визуального представления кнопки.
    public var body: some View {
        Button(action: startLoading) {
            ZStack {
                Circle()
                    .stroke(lineWidth: size / 10)
                    .opacity(0.3)
                    .foregroundColor(color)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: size / 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270))
                
                if showCheckmark {
                    Image(systemName: "checkmark")
                        .font(.system(size: size / 4))
                        .foregroundColor(color)
                } else {
                    Text(progressText)
                        .font(.system(size: size / 5))
                        .foregroundColor(color)
                }
            }
        }
        .frame(width: size, height: size)
    }
    
    /// Метод, инициирующий запуск анимации прогресса.
    /// Отменяет предыдущий таймер, если он был активен, устанавливает прогресс в 0 и запускает таймер.
    private func startLoading() {
        timer?.invalidate() // Отменяем предыдущий таймер, если он был активен
        progress = 0
        progressText = "0%"
        showCheckmark = false
        timer = Timer.scheduledTimer(withTimeInterval: duration / 100, repeats: true) { _ in
            withAnimation(.linear(duration: self.duration / 100)) {
                self.progress += 0.01
            }
            self.progressText = "\(Int(self.progress * 100))%"
            if self.progress >= 1.0 {
                self.showCheckmark = true
                self.timer?.invalidate()
                self.action()
            }
        }
    }
}
