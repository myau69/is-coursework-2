-- dorm_booking: бронирование общих комнат (переговорок) по слотам 30 минут

CREATE TABLE shared_room (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    description TEXT,
    capacity    INTEGER CHECK (capacity > 0),
    created_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE schedule (
    id           SERIAL PRIMARY KEY,
    room_id      INTEGER NOT NULL UNIQUE REFERENCES shared_room (id) ON DELETE CASCADE,
    days_of_week SMALLINT[] NOT NULL,          -- дни недели: 1 = пн ... 7 = вс
    start_time   TIME NOT NULL,
    end_time     TIME NOT NULL,
    CHECK (start_time < end_time)
);

CREATE TABLE slot (
    id        SERIAL PRIMARY KEY,
    room_id   INTEGER NOT NULL REFERENCES shared_room (id) ON DELETE CASCADE,
    starts_at TIMESTAMP NOT NULL,
    ends_at   TIMESTAMP NOT NULL,
    CHECK (starts_at < ends_at)
);

-- user_id — id пользователя из dorm_identity (FK между базами невозможен)
CREATE TABLE booking (
    id              SERIAL PRIMARY KEY,
    slot_id         INTEGER NOT NULL REFERENCES slot (id),
    user_id         INTEGER NOT NULL,
    status          TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'cancelled')),
    conference_link TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT now(),
    cancelled_at    TIMESTAMP
);

-- Индексы

-- Слоты комнаты на нужную дату — сразу по времени
CREATE INDEX slot_room_time_idx ON slot (room_id, starts_at);

-- «Мои брони» пользователя
CREATE INDEX booking_user_idx ON booking (user_id);

-- Защита от двойной брони: на слот только одна активная бронь
CREATE UNIQUE INDEX booking_one_active_per_slot ON booking (slot_id) WHERE status = 'active';
