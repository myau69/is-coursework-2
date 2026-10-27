-- dorm_study: учебные комнаты и отметки «я здесь занимаюсь» (на 2 часа)

CREATE TABLE study_room (
    id          SERIAL PRIMARY KEY,
    number      TEXT NOT NULL UNIQUE,
    name        TEXT NOT NULL,
    chair_count INTEGER NOT NULL CHECK (chair_count >= 0)
);

-- finished_at IS NULL — человек ещё в комнате (пока не истёк expires_at)
CREATE TABLE study_presence (
    id          SERIAL PRIMARY KEY,
    room_id     INTEGER NOT NULL REFERENCES study_room (id),
    user_id     INTEGER NOT NULL,
    started_at  TIMESTAMP NOT NULL DEFAULT now(),
    expires_at  TIMESTAMP NOT NULL,
    finished_at TIMESTAMP
);

-- Индексы

-- Кто сейчас в комнате — подсчёт свободных мест
CREATE INDEX presence_room_idx ON study_presence (room_id);

-- Текущая отметка пользователя (check-in / check-out)
CREATE INDEX presence_user_idx ON study_presence (user_id);
