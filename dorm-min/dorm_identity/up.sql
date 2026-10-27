-- dorm_identity: пользователи, жилые комнаты, права доступа

CREATE TABLE residential_room (
    id     SERIAL PRIMARY KEY,
    number TEXT NOT NULL UNIQUE
);

CREATE TABLE permission (
    id   SERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL
);

-- "user" — зарезервированное слово, поэтому app_user
CREATE TABLE app_user (
    id                  SERIAL PRIMARY KEY,
    isu                 TEXT UNIQUE,
    email               TEXT NOT NULL UNIQUE,
    password_hash       TEXT NOT NULL,
    full_name           TEXT NOT NULL,
    phone               TEXT,
    photo_ref           TEXT,
    residential_room_id INTEGER REFERENCES residential_room (id),
    created_at          TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE user_permission (
    user_id       INTEGER NOT NULL REFERENCES app_user (id) ON DELETE CASCADE,
    permission_id INTEGER NOT NULL REFERENCES permission (id),
    granted_by    INTEGER REFERENCES app_user (id),
    granted_at    TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (user_id, permission_id)
);

-- Индексы

-- Жильцы комнаты — нужно для рассылки объявлений по комнатам
CREATE INDEX app_user_room_idx ON app_user (residential_room_id);
