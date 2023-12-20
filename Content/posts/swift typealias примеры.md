---
date: 2023-12-19 1:48
description: как можно использовать
tags: 
path: swift-typealias-example
---
# Swift typealias примеры
Основной момент, чтобы поменять контекст уже используемых типов, обозвать, так чтобы было понятно в новом контексте. Альтернативное имя (абстракция), которое позволяет быстрее понять контекст.

```swift
typealias UserID = Int
typealias Username = String
typealias JSONDictionary = [String: Any]
```


Более специализированные применения:
- краткие записи замыканий
```swift
typealias CompetionHandler<T> = (Result<T, Error>) -> Void // можно использовать в сервисах, которые что-то запрашивают
```

- более короткие записи (когда ссылаются на дочерные типы, вложенности, ассоциированные типы и т.д.)
 
```swift
	public protocol IteratorProtocol {    
	/// The type of element traversed by the iterator.    
	associatedtype Element
}

protocol Sequence {    
	associatedtype Iterator: IteratorProtocol    
	typealias Element = Iterator.Element
}

func sum<T: Sequence>(_ sequence: T) -> Int where T.Element == Int {    // ...}

```
- группировать протоколы 

```swift
public typealias Codable = Decodable & Encodable
```
- можно использовать typealias с generic-ами, для тюплов
```swift
typealias Point<T: Numeric> = (x: T, y: T)

enum APIError: Error {}
typealias APIResult<Success> = Result<Success, APIError> 
typealias NoContent = Result<Void, APIError> 
```
- поддержка разных платформ и архитектур

```swif
#if os(iOS)
typealias Color = UIColor

#elseif os(macOS)
typealias Color = NSColor

#endif

let backgroundColor: Color = .white
```

- [миграция](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-a-complex-migration-using-versionedschema) на какой-то новый тип
```
typealias OldType = NewType
```
[Swift typealias: What is it and when to use it]()(https://sarunw.com/posts/swift-typealias/)

https://www.swiftwithvincent.com/blog/hidden-feature-typealias


## Куда дальше
[[заметки разработки iOS Swift]]