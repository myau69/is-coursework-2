-- dorm_gym: допуск в спортзал (инструкция → подтверждение → заявка → пропуск)

CREATE TABLE safety_instruction_version (
    id           SERIAL PRIMARY KEY,
    version      TEXT NOT NULL UNIQUE,
    content      TEXT NOT NULL,
    published_at TIMESTAMP NOT NULL DEFAULT now(),
    published_by INTEGER NOT NULL           -- id сотрудника из dorm_identity
);

CREATE TABLE safety_acknowledgement (
    id                     SERIAL PRIMARY KEY,
    user_id                INTEGER NOT NULL,
    instruction_version_id INTEGER NOT NULL REFERENCES safety_instruction_version (id),
    acknowledged_at        TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE gym_access_application (
    id                 SERIAL PRIMARY KEY,
    user_id            INTEGER NOT NULL,
    certificate_ref    TEXT NOT NULL,       -- ссылка на медсправку
    acknowledgement_id INTEGER NOT NULL UNIQUE REFERENCES safety_acknowledgement (id),
    status             TEXT NOT NULL DEFAULT 'submitted'
                       CHECK (status IN ('submitted', 'approved', 'rejected')),
    submitted_at       TIMESTAMP NOT NULL DEFAULT now(),
    reviewed_by        INTEGER,
    reviewed_at        TIMESTAMP,
    decision_note      TEXT
);

CREATE TABLE gym_access_permit (
    id             SERIAL PRIMARY KEY,
    application_id INTEGER NOT NULL UNIQUE REFERENCES gym_access_application (id),
    issued_at      TIMESTAMP NOT NULL DEFAULT now(),
    expires_at     TIMESTAMP NOT NULL
);

-- Индексы

-- Заявки пользователя — проверка допуска на входе в зал
CREATE INDEX application_user_idx ON gym_access_application (user_id);

-- Заявки по статусу — список «ждут рассмотрения» для тренера
CREATE INDEX application_status_idx ON gym_access_application (status);
