---
date: 2023-10-21 17:37
description: пошаговый мануал
path: publish-swift-server-blog
---
# Настройка swift server блога

Тут описываю пошаговую настройку **swift сервера** для настройки **персонального блога на своем домене**. То есть как этот блог завелся))

Без покупки хостинга настроить блог можно условно-бесплатно по этой инструкции [[бесплатный генератор Swift Publish блога на Netlify]]
## 0.  Покупка хостинга. Предварительная настройка
До этого настраивал хостинг на https://digitalocean.com но с успехом воспроизвел установку блога на vps https://jino.ru
Взял тариф **Бета** + выделенный IP адрес - подобное подключение услуг встало в 550 руб за месяц. И 450 руб/месяц. 


Для сравнения из коробки сервис [Publish от Obsidian](https://obsidian.md/publish)  стоит 950 руб в месяц, умеет из коробки строить красивый граф, стильно выглядит и быстро работает (посмотрите [пример страниц](https://publish.obsidian.md/help-ru/Начните+здесь)). 

В моем случае на хостинге я еще поднимаю чат-ботов, написаных тоже на swift, об этом в других статьях [[настройка чат-бота telegram chatbot]]


Очень рекомендую закрыть доступ по паролю к серверу и сделать по ssh ключу - настройки [здесь](https://jino.ru/spravka/articles/initial_ubuntu.html#создание-нового-пользователя) 
Как открыть порты в **ufw** для Nginx [здесь](https://itecnote.com/tecnote/nginx-error-could-not-find-a-profile-matching-nginx-full/)
## 1. Настройка А-записей в домене
Вот пример записей для корневого сайта **popyvanov.ru**, и блога **s.popyvanov.ru**

```
|  s  |  A  |217.107.34.36|
|  @  |  A  |217.107.34.36|
```

Покупаю домены [тут](https://domains.webmoney.ru/) но вариантов тьма
## 2. Настройка nginx веб-сервера для доступа к сайту-заглушке


Не буду сильно расписывать. Но главное внимательно проверяйте пути в конфигах
```bash
sudo apt update
sudo apt install nginx
```

Настройка **/etc/nginx/nginx.conf**
```
user  nginx;
worker_processes  auto;

pid        /var/run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    gzip  on;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-available/*;
}

```

В папке **/etc/nginx/sites-available/** - храню файлик **default** с настройками ниже

```
server {
    listen 80;
    server_name popyvanov.ru;

    root /var/www/popyvanov.ru;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Посе всех настроек перезагружаем nginx
```
sudo systemctl restart nginx
```
И очень полезно юзать эту команду для отладки конфигурации (покажет где не поставили ;)
```
nginx -t
```
а так же смотреть логи nginx
**/var/log/nginx/access.log**
**/var/log/nginx/errors.log** 

С такими настройками, как выше у меня работаете сайт-заглушка [popyvanov.ru](http://popyvanov.ru)

## 3. Установить swift на сервер

Основной мануал по установке [swift](https://docs.vapor.codes/deploy/digital-ocean/#install-swift) 
Но необходимо для начала поставить необходимые зависимости, брал [отсюда](https://www.swift.org/install/linux/#installation-via-docker) тут более полный список что ли)))

```
apt-get install \
          binutils \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4-openssl-dev \
          libedit2 \
          libgcc-9-dev \
          libpython3.8 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2-dev \
          libz3-dev \
          pkg-config \
          tzdata \
          unzip \
          zlib1g-dev
```
На момент публикации поставил себе версию 5.8.1
## 4. Настройка своего Publish-сайта

По [инструкции](https://github.com/JohnSundell/Publish#quick-start) того же Джона Санделла, создаем свой "рецепт" блога. То есть настраиваем основные блоки сайта, собираем нужные страницы, подключаем плагины и т.д. Как раз все свои последующие доработки я буду делать, чтобы заточить движок блока под те задачи, которые мне нужны. 

```
git clone git clone https://github.com/flyer2001/myBlog
cd myBlog
swift run
```
После этого действия в папке myBlog/Output - будет лежат статичный сайт с нужными страницами
Создадим "ярлык" на папку, где будет лежать наш сайт
```
cd /var/www/popyvanov.ru 
ln -s /myBlog/Output/ s
```

добавим в файлик /etc/nginx/sites-available/default еще один серверный блок для нашего домена
```
server {
    listen 80;
    server_name s.popyvanov.ru;

    root /var/www/popyvanov.ru/s;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
Перезагружаем nginx
```
sudo systemctl restart nginx
```
 
И по и после этого сайт доступен, но пока по 80 http порту http://s.popyvanov.ru

## 5. Настройка https для блога
После того, как вы создали серверный блог для вашего домена (у меня это s.popyvanov.ru), проделываем магию с помощью бесплатного сертификата Encrypt
Подробный мануал [тут](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04)

если все проходит гладко, то появляется доп запись в /etc/nginx/sites-available/default
```
server {
    server_name s.popyvanov.ru;

    root /var/www/popyvanov.ru/s;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/s.popyvanov.ru/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/s.popyvanov.ru/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = s.popyvanov.ru) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name s.popyvanov.ru;
    return 404; # managed by Certbot


}
```
В настройках админки хостинга https://cp.jino.ru необходимо **отключить проксирование** https. **Управление -> Выделенные IP -> Проксировать HTTPS**

После этого ваш блог безопасно откроется по адресу
https://s.popyvanov.ru
## 6. Ручной деплой сайта
Каждый раз, после того, как в репозиторий сайта улетают новые страницы, делаю следующие команды на хостинге
```
cd /myBlog
git pull
publish generate
```

А чтобы немного это автоматизировать идем сюда - [[автоматическая публикация сайта с использованием Github Actions]]
## Куда дальше?
[[процесс публикации статьи в Swift Publish]]

[[бесплатный генератор Swift Publish блога на Netlify]]

[[автоматическая публикация сайта с использованием Github Actions]]

[[как добавить обработку вики ссылок в блог Publish]]

[[персональный домен]]

**Есть вопросы?** - задавай смело [тут](https://t.me/serg_popyvanov_blog/10) 