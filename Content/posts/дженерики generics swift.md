---
date: 2023-12-29 12:03
description: зачем нужны
tags: 
path: generics-swift
---
# Swift Generic
Согласно официальной [документации](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) 
Generic (универсальный код) - позволяет создать переиспользуемые методы и структуры для общих методов с разными типами данных. При этом управление типами перекладывается на компилятор. 

Самые популярные кейсы

## Создание универсальных структур, коллекций

```swift
struct Stack<T> {
    var items = [T]()

    mutating func push(item: T) {
        items.append(item
    }

    mutating func pop() -> T? {
        return items.popLast()
    }
}
```

## Различные типы данных (универсальность) и ограничения
```swift

func sum<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

func swapValues<T>(a: inout T, b: inout T) {

    let temp = a
    a = b
    b = temp
}
```
есть [кейсы](https://sarunw.com/posts/how-to-explicitly-specialize-generic-function-in-swift/) для "специализации" методов 
## Популярные кейсы ипользования
- объекты для хранения в [CoreData](https://obscuredpixels.com/combining-core-data-with-generics)
- создание [extension](https://www.swiftbysundell.com/articles/specialized-extensions-using-generic-type-constraints/) для определенных коллекций, классов 
- только в путь для [сервисов](https://udaypatial.medium.com/writing-a-generic-reusable-networking-layer-using-combine-swift-ios-fe8e16404a13), которые получают разные типы данных из сети
- для создания библиотек и фреймворков, и особенно для [dependency injection](https://benoitpasquier.com/modular-app-dependency-injection-generics-swift/)
## Как это работает под капотом?

Если хочется совсем глубины, есть книга [Compiling Swift Generics - Slava Pestov](https://download.swift.org/docs/assets/generics.pdf) - тут про то, как это на уровне компилятора работает

## Куда дальше
[[заметки разработки iOS Swift]]

