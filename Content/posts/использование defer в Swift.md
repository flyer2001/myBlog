---
date: 2023-12-21 15:34
description: кейсы использования
tags: 
path: defer-swift
---
# Использование defer в Swift
defer - это отложенная, но гарантированная к исполнению работа, которая будет проделанная в используемом куске кода. 

```swift
print("Шаг 1")
do {
    defer { print("Шаг 2") }
    print("Шаг 3")
    print("Шаг 4")

}
print("Шаг 5")
// 1, 3, 4, 2, 5
```
популярный кейс - это обновить UI после получения данных или каких-то расчетов

## Очистка ресурсов после выполенния
Отложенное выполнение closeFile - гарантируется даже, когда guard выкидывает из метода. 
```swift
func writeLog() { 
	let file = openFile() 
	defer { closeFile(file) } 
	let hardwareStatus = fetchHardwareStatus() 
	guard hardwareStatus != "катастрофа" else { return } 
	file.write(hardwareStatus) 
	let softwareStatus = fetchSoftwareStatus() 
	guard softwareStatus != "катастрофа" else { return } 
	file.write(softwareStatus) 
	let networkStatus = fetchNetworkStatus() 
	guard neworkStatus != "катастрофа" else { return } 
	file.write(networkStatus) }
```

## Управление блокировками
```swift
func doSomethingSynchronized() {
    lockResource()
    defer {
        unlockResource()
    }
    // здесь что то делаем
}
```

## Источники
[статья на medium](https://medium.com/@SwiftBook.ru/%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%B2%D0%BE%D0%B5-%D1%81%D0%BB%D0%BE%D0%B2%D0%BE-defer-34828b59f709)

[[Каталог разработки под iOS]]

## Куда дальше
[[заметки разработки iOS Swift]]