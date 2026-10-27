-- dorm_laundry: прачечная (заказ → партии (контейнеры) → услуги по тарифу)

CREATE TABLE laundry_order (
    id                   SERIAL PRIMARY KEY,
    user_id              INTEGER NOT NULL,
    received_at          TIMESTAMP NOT NULL,
    registered_at        TIMESTAMP NOT NULL DEFAULT now(),
    contact_phone        TEXT NOT NULL,
    declared_paid_amount NUMERIC(10,2) NOT NULL CHECK (declared_paid_amount >= 0)
);

CREATE TABLE laundry_batch (
    id               SERIAL PRIMARY KEY,
    order_id         INTEGER NOT NULL REFERENCES laundry_order (id) ON DELETE CASCADE,
    container_number TEXT NOT NULL
);

CREATE TABLE laundry_service (
    id   SERIAL PRIMARY KEY,
    code TEXT NOT NULL UNIQUE CHECK (code IN ('wash', 'dry')),
    name TEXT NOT NULL
);

CREATE TABLE laundry_tariff (
    id          SERIAL PRIMARY KEY,
    service_id  INTEGER NOT NULL REFERENCES laundry_service (id),
    price       NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    valid_from  TIMESTAMP NOT NULL,
    valid_until TIMESTAMP CHECK (valid_until > valid_from)   -- NULL = действует сейчас
);

CREATE TABLE laundry_batch_service (
    batch_id  INTEGER NOT NULL REFERENCES laundry_batch (id) ON DELETE CASCADE,
    tariff_id INTEGER NOT NULL REFERENCES laundry_tariff (id),
    PRIMARY KEY (batch_id, tariff_id)
);

CREATE TABLE laundry_rejection_report (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    occurred_at TIMESTAMP NOT NULL,
    reported_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE laundry_intake_closure (
    id            SERIAL PRIMARY KEY,
    stopped_by    INTEGER NOT NULL,
    business_date DATE NOT NULL,
    stopped_at    TIMESTAMP NOT NULL DEFAULT now()
);

-- Индексы

-- «Мои заказы» пользователя
CREATE INDEX order_user_idx ON laundry_order (user_id);

-- Заказы за период — расчёт загрузки прачечной
CREATE INDEX order_received_at_idx ON laundry_order (received_at);

-- Партии одного заказа
CREATE INDEX batch_order_idx ON laundry_batch (order_id);
