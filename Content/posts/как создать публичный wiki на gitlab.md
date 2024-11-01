---
date: 2024-11-01 14:34
description: публичный wiki
tags: 
path: wiki-gitlab
---
# Как создать публичный wiki на gitlab

Уже несколько раз была необходимость публиковать свои заметки во вне. У Obsidian есть платный инструмент [publish](https://obsidian.md/publish) и возможно все, что я опишу ниже можно сделать там без танцев с бубном как тут. 

Возможно тем, кто не связан с разработкой использовать git (систему контроля версий) будет сложно. Но на самом деле главное разобраться в базовых операциях: clone, commit и уже во всю пользоваться. 

wiki в gitlab умеет:
- работать из коробки с md файлами
- знает про линковку статей через [[]] 
- умеет отображать картинки
- есть встроенный поиск
- можно через веб-версию 

что gitlab делает плохо:
- открывает статьи которые помечены просто через [[]] - в новом окне, может быть не очень удобно для навигации
- это лечится ссылкой через квадратные и круглые скобки []()
- не умеет хештеги (это лечится поиском по хештегу, но нет такого удобства как в Obsidian)

То есть мы "переиспользуем" уже созданные нами статьи, минимально их готовя к публикации (переместить в папку и выполнить команду commit)

Ниже инструкция как настроить
## 0. Зарегистрироваться на сайте gitlab.com и создать репозиторий

Клонировать нужно не сам репозиторий а именно wiki (см. скрин ниже)

![[gitlab wiki clone.png]]

 ## 1. Склонировать репозиторий
 Я сделал это внутрь папки своего obsidian хранилища. Создал папку digitalGarden и склонировал репозиторий wiki в эту папку. Теперь мне стоит перенести сюда заметку + картинку, если нужно ее показать. 

## 2. Коммит после каждого изменения
И после всех сделанных изменений сделать коммит и найти опубликованные данные в wiki.

