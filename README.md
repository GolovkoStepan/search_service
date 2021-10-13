# Search service

Сервис ежедневно собирает данные с https://napi.wildberries.ru и отдает по маршруту
/search/:product где product - идентификатор товара.

Запуск:

- Установить зависимости
```shell
bundle install
```

- Создать БД
```shell
rails db:create
```

- Запустить миграции
```shell
rails db:migrate
```

- Запустить загрузку данных
```shell
rake load_products
```

- Обновить расписание cron
```shell
whenever --update-crontab
```

- Запустить сервер
```shell
rails s
```