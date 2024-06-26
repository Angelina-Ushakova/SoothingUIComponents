# ProgressButton

Кнопка с индикатором прогресса, которая запускает заданное действие и отображает анимированный прогресс выполнения.

## Описание

Этот компонент подходит для задач, где пользователю необходимо видеть визуальный индикатор выполнения процесса, например, при загрузке файлов или обработке данных.

## Как это работает

`ProgressButton` начинает с состояния 0% и плавно переходит к 100% за время, заданное параметром `duration`. По достижении 100%, отображается галочка, и выполняется замыкание `action`.

## Инициализация

Для создания `ProgressButton` используйте следующий инициализатор:

- ``ProgressButton/init(duration:size:color:action:)``

## Пример использования

```swift
ProgressButton(duration: 2.0, size: 50, color: .blue) {
    print("Прогресс завершен!")
}
