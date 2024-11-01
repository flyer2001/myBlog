---
date: 2023-10-27 11:35
description: Делюсь как выглядит публикация Obsidian заметки через Swift Publish - бесплатную альтернативу Obsidian Publish.
tags: 
path: publish-note-with-swift-publish
---
# Процесс публикации статьи в Swift Publish

Опубликовано уже достаточно заметок, как настроить публикацию заметок, настроить свой сервер под это дело ([[куда дальше]] )

Пора показать, как это выглядит теперь. Записал видео, демонстрирующее, как заметка внутри Obsidian становится публичной. 
Если кратко, то нужно:

- перенести заметку внутрь репозитория SwiftPublish (в папку с постами, из которых собирается сайт)
- добавить мета-данные для будущей статьи
- опубликовать (= сделать коммит)



<iframe width="560" height="315" src="https://www.youtube.com/embed/-2CRotWdV34?si=PV25KiRcyT0bIEzq" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

И немного лирики:

У Obsidian есть свой продукт [Publish](https://obsidian.md/publish), который может вот [такие](https://publish.obsidian.md/help-ru/Начните+здесь) красивые страницы делать.

По идее бери и используй из коробки, ничего не программируя. Но.

- готовое решение стоит 10 долларов в месяц (900 руб), вариант со своим хостингом порядка 450 руб в месяц, да и трудности оплаты из России никто не отменял*
- сложно настроить под себя (сделать блог, сверстать какую-то шапку персонального сайта, добавить какой-то интерактив, прикрутить оплату и т.д.)

(*) - есть вариант, как можно сильно удешевить это (если в складчину несколько владельцев блога будут публиковаться в одном месте, использовать хостинг для чат-ботов)

И есть еще один вариант как это сильно удешивить, а точнее сделать условно-бесплатным - это использовать [[бесплатный генератор Swift Publish блога на Netlify]]

## Куда дальше 

[[бесплатный генератор Swift Publish блога на Netlify]]  
[[настройка swift server блога]]  
[[как помочь поисковикам найти ваш сайт SEO]]  