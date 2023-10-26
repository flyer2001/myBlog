---
date: 2023-10-22 23:55
description: колхозный devops через github actions
tags: 
path: devops-hello-world
---
# Автоматическая публикация сайта с использованием Github Actions
Подозревал, что можно использовать Github Actions для автоматизации

## Подготовка
- клонируем' репозиторий блога https://github.com/flyer2001/myBlog
- клонируем' и разворачиваем генератор статических страниц https://github.com/flyer2001/Publish

(') - Об этом подробнее тут  [[настройка swift server блога]] 

## Что хотим автоматизировать
Каждый раз когда в репозиторий блога прилетает обновление (= публикация нового контента) нужно запускать три команды:
- перейти в папку с блогом
- выполнить команду git pull
- сгенерировать статичные страницы
```
cd /myBlog
git pull
publish generate
```

## Установка self-hosted runner 

Необходимо установить self-hosted Runner для автоматического запуска команд при обновлении репозитория.

Внутри репозитория блога на github захожу в **Settings -> Actions -> Runners**  и жму кнопку **New self-hosted runner**

Там подробная инструкция как установить раннер. За исключением того, как запустить его как сервис (= чтоб он сам запускался). Для этого есть отдельная [дока](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service)

Если кратко, то нужно в папке с установленным actions-runner запустить уже готовый скрипт:
```
sudo ./svc.sh install
sudo ./svc.sh start
```
## Настройка runner'а
 
Жмем на сайте Github: **actions -> setup workflow your self**
Репозиторий предложить добавить yaml файл. Вот как выглядит мой файл

```
name: PublishSwift

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: SSH to server and execute commands
      uses: appleboy/ssh-action@v1.0.0
      with:
        host: popyvanov.ru
        username: root
        password: ${{ secrets.SSH_PASSWORD }}
        script: |
          cd /myBlog
          git pull
          publish generate
          exit

```

Жмем **commit**

Очень колхозный вариант, надеюсь кто-то из devops-инженеров взглянут на этот колхоз и подкинут, как это сделать более безопасно. Но что тут происходит:
- после коммита в репозиторий с блогом поднимается ssh подключение сервера к самому же себе
- выполняются команды 

secrets.ssh_password - это переменная, которую нужно положить внутри вашего репозитория в разделе **Settings -> Secrets and Variables - Actions -> New Repository Secret**

Если все настроено правильно, то во вкладке **actions** после каждого коммита будем видеть вот такую красоту. И на сервер после этого можно не подключаться))))

![](https://habrastorage.org/webt/jg/2a/_1/jg2a_1mqdxfmzo3bw3tkgszdg2a.png)

## Куда дальше?
[[настройка swift server блога]]