-- dorm_office: административные кабинеты, их услуги и живая очередь

CREATE TABLE administrative_office (
    id            SERIAL PRIMARY KEY,
    number        TEXT NOT NULL UNIQUE,
    name          TEXT NOT NULL,
    description   TEXT NOT NULL,
    opening_hours TEXT NOT NULL
);

CREATE TABLE office_service (
    id          SERIAL PRIMARY KEY,
    office_id   INTEGER NOT NULL REFERENCES administrative_office (id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    description TEXT
);

-- finished_at IS NULL — человек ещё стоит в очереди
CREATE TABLE office_queue_presence (
    id          SERIAL PRIMARY KEY,
    office_id   INTEGER NOT NULL REFERENCES administrative_office (id),
    user_id     INTEGER NOT NULL,
    joined_at   TIMESTAMP NOT NULL DEFAULT now(),
    finished_at TIMESTAMP CHECK (finished_at >= joined_at)
);

-- Индексы

-- Очередь конкретного кабинета
CREATE INDEX queue_office_idx ON office_queue_presence (office_id);

-- Нельзя встать в очередь одного кабинета дважды
CREATE UNIQUE INDEX queue_one_per_user ON office_queue_presence (office_id, user_id) WHERE finished_at IS NULL;
