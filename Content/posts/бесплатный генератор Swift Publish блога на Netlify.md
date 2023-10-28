---
date: 2023-10-28 23:22
description: свой блог за три щелчка мышки
tags: 
path: swift-publish-with-netlify
---
# Бесплатный генератор swift publish блога на Netlify

Прикольно что все мои приседания с [[настройка swift server блога]] - помогли мне получить много ценного опыта в разворачивании окружения в Linux, натстройке nginx, фаервола и прочие веселья.

Если есть желание быстро и бесплатно попробовать, можно сделать следующее:

1) Форкнуть и склонировать [репозиторий блога](https://github.com/flyer2001/myBlog)  ( как вариант внутрь папки своего Obsidian хранилища см. подробнее [[процесс публикации статьи в Swift Publish]])
2) Залогиниться в [netlify](https://www.netlify.com) с помощью **github** аккаунта
3) Подключить свой репозиторий (кнопка add new site - **подробнее смотри ниже в видео**)

Дальше после коммита в ваш репозиторий (= добавление новых статей) - сайт пересоберет все страницы и обновит их за вас (вместо всей магии тут [[автоматическая публикация сайта с использованием Github Actions]])

Дальше уже можно подключить свой домен на сайт, чем и займусь в ближайшее время. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/blDVlnE_aDc?si=96xHg8coZLIz-s5e" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Источники

[Настройка на netlify](https://www.youtube.com/watch?v=oc9ZkhPiQu0) - видео, с которого я подсмотрел это решение

## Куда дальше
[[процесс публикации статьи в Swift Publish]]

[[настройка swift server блога]]

[[персональный домен]]

[[автоматическая публикация сайта с использованием Github Actions]]