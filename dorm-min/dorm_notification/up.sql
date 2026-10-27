-- dorm_notification: объявления, статусы оплаты проживания, личные уведомления

CREATE TABLE announcement (
    id            SERIAL PRIMARY KEY,
    author_id     INTEGER NOT NULL,
    title         TEXT NOT NULL,
    body          TEXT NOT NULL,
    audience_mode TEXT NOT NULL CHECK (audience_mode IN ('all_residents', 'selected')),
    published_at  TIMESTAMP NOT NULL DEFAULT now()
);

-- Кому адресовано объявление в режиме 'selected': комнаты и/или отдельные люди
CREATE TABLE announcement_room_target (
    announcement_id     INTEGER NOT NULL REFERENCES announcement (id) ON DELETE CASCADE,
    residential_room_id INTEGER NOT NULL,
    PRIMARY KEY (announcement_id, residential_room_id)
);

CREATE TABLE announcement_user_target (
    announcement_id INTEGER NOT NULL REFERENCES announcement (id) ON DELETE CASCADE,
    user_id         INTEGER NOT NULL,
    PRIMARY KEY (announcement_id, user_id)
);

CREATE TABLE monthly_accommodation_payment_status (
    id                       SERIAL PRIMARY KEY,
    user_id                  INTEGER NOT NULL,
    year                     INTEGER NOT NULL,
    month                    INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    payment_state            TEXT NOT NULL DEFAULT 'unknown'
                             CHECK (payment_state IN ('paid', 'unpaid', 'unknown')),
    paid_at                  TIMESTAMP,
    provider_updated_at      TIMESTAMP,
    last_successful_check_at TIMESTAMP,
    UNIQUE (user_id, year, month)
);

-- Уведомление ссылается на то, о чём оно (объявление, оплата, учебная комната или заявка в зал)
CREATE TABLE personal_notification (
    id                 SERIAL PRIMARY KEY,
    recipient_id       INTEGER NOT NULL,
    kind               TEXT NOT NULL
                       CHECK (kind IN ('announcement', 'payment_reminder', 'study_confirmation', 'gym_decision')),
    announcement_id    INTEGER REFERENCES announcement (id),
    payment_status_id  INTEGER REFERENCES monthly_accommodation_payment_status (id),
    study_presence_id  INTEGER,
    gym_application_id INTEGER,
    body               TEXT NOT NULL,
    created_at         TIMESTAMP NOT NULL DEFAULT now(),
    read_at            TIMESTAMP
);

-- Индексы

-- Лента уведомлений пользователя
CREATE INDEX notification_recipient_idx ON personal_notification (recipient_id);

-- Кто не оплатил за месяц — для напоминаний
CREATE INDEX payment_month_idx ON monthly_accommodation_payment_status (year, month);
