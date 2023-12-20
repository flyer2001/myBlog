# Инициализаторы словарей Swift

[[Каталог разработки под iOS]]

## Объединение двух массивов в словарь

```swift
let nameList = ["Leo", "ana", "manzoni", "jonas"]
let ageList = [30, 26, 32, 44]

let nameAgeDictionary = Dictionary(uniqueKeysWithValues: zip(nameList, ageList))

// Можно было и так
let nameAgeList = [("leo",30),("ana",26),("manzoni",33)]
let nameAgeDictionary2 = Dictionary(uniqueKeysWithValues: nameAgeList)

```
zip - возвращает массив tuples, из которых создается словарь

## Ограничение размера словаря
Возможно эту штуку можно использовать для супер узких специализаций, когда само динамическое выделение памяти под словарь - не устраивает по скоростои. 
```swift
let myDictionary = Dictionary<String,Int>(minimumCapacity: 50) // vanilla syntax
let myDictionary2 = [String:Int](minimumCapacity: 50) // sugar syntax
```

## Когда имеются списки, где повторяются ключи

```swift
let fileList = ["file1", "file2", "file1", "file3", "file2", "file1"]
let timestampList = [30, 20, 44, 222, 87, 66] // можно представить, что это даты изменения файлов

let filesTimestampDictionary = Dictionary<String,Int>(zip(fileList, timestampList)) { 
(first, second) -> Int in // 1 - захватываем первый и второй (в данном случае последний) параметр
    second // 2- какой из ключей будет выбран
}

print(filesTimestampDictionary) // ["file3: 222, "file2": 87, "file1": 44]
```

### Группировка данных по ключу

Группирует возраст студентов
```swift

let studentsAgeList = [3,5,5,2,9,9,10,12,2,5] // неотсортированный массив
let ageGroupedList = Dictionary(grouping: studentsAgeList) { $0 } // здесь создаем новый словарь, ключом которого является значение возраста, а в значении лежит массив повторяющихся ззначений возрастов
print(ageGroupedList) // [2: [2, 2], 10: [10], 9: [9, 9], 12: [12], 3: [3], 5: [5, 5, 5]]

print("У нас есть \(studentsAgeList.count) студентов \(ageGroupedList.count) различных возрастов")>)
// У нас есть 10 студентов 6 различных возрастов
```
Группирует название городов по первой букве
```swift
let cityList = ["Santo Andre", "Maua", "Diadema", "San Paolo",
                "Salvador", "Natal", "Diamantina" , "Monte Verde"]
let cityGroupedList = Dictionary(grouping: cityList) { $0.first! }

print(cityGroupedList) // ["N" : ["Natal"], "D": ["Diadema", "Diamantina"]...]
```
И получается группировать можно по любым  значениям, которые можно сравнить.

## Источники
[Неизвестные инициализаторы словарей](https://holyswift.app/the-lesser-known-dictionary-initializers-in-swift)

## Куда дальше
[[заметки разработки iOS Swift]]