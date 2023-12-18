---
date: 2023-12-18 15:37
description: final class
tags: 
path:
---
# Когда нужно ставить final

на автомате ставлю везде, но на самом деле нужно ставить только для публичных классах, так как их наследовать могут другие модуль.
Для internal классов есть оговорка про включенную Whole Module Optimization

[Источник со ссылками на доку Apple](https://samwize.com/2023/12/15/should-you-add-final-to-all-your-swift-classes/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=web&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B640)
