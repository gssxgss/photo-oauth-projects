# RAILS APP

## run server

```bash
 $ docker compose build
 $ docker compose up
 $ docker compose exec app db:setup
 ```

## cost time

- docker setups: 5h+
- coding: 10h+
- styling: 2h+
- test: 1h+

## How to use

1. メールに添付された `master.key` を `rails_app/config/master.key` に保存してください
2. `http://localhost:3000` にアクセスして、「ユーザー登録」してください

## Gem used

- carrierwave
