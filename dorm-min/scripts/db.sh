#!/usr/bin/env bash
# Использование: ./scripts/db.sh reset | up | down | seed
#   up    — создать базы (если их нет), таблицы, индексы и триггеры (up.sql + functions.sql)
#   seed  — залить тестовые данные (seed.sql)
#   down  — удалить всё из баз (down.sql); сами базы остаются
#   reset — down + up + seed
set -euo pipefail
cd "$(dirname "$0")/.."

DBS="dorm_booking dorm_gym dorm_identity dorm_laundry dorm_notification dorm_office dorm_study"
export PGOPTIONS="-c client_min_messages=warning"   # не выводить NOTICE от DROP IF EXISTS

run() {   # run <база> <файл без .sql>
  echo "  $1/$2.sql"
  psql -X -q -v ON_ERROR_STOP=1 -d "$1" -f "$1/$2.sql"
}

db_exists() {
  psql -X -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname = '$1'" | grep -q 1
}

up() {
  for db in $DBS; do
    db_exists "$db" || createdb "$db"
    run "$db" up
    run "$db" functions
  done
}

seed() {
  for db in $DBS; do run "$db" seed; done
}

down() {
  for db in $DBS; do
    if db_exists "$db"; then run "$db" down; fi
  done
}

case "${1:-}" in
  up)    up ;;
  seed)  seed ;;
  down)  down ;;
  reset) down; up; seed ;;
  *) echo "Использование: $0 reset | up | down | seed"; exit 1 ;;
esac
echo "Готово"
