INSERT INTO administrative_office (number, name, description, opening_hours) VALUES
    ('104', 'Паспортный стол', 'Регистрация по месту пребывания', 'Пн–Пт 10:00–17:00'),
    ('110', 'Комендант',       'Заселение, пропуска',             'Пн–Пт 09:00–18:00');

INSERT INTO office_service (office_id, name) VALUES
    (1, 'Временная регистрация'),
    (1, 'Справка о регистрации'),
    (2, 'Переселение'),
    (2, 'Гостевой пропуск');

-- Трое стоят в очереди в паспортный стол, один уже ушёл от коменданта
INSERT INTO office_queue_presence (office_id, user_id, joined_at, finished_at) VALUES
    (1, 6, now() - interval '20 minutes', NULL),
    (1, 7, now() - interval '15 minutes', NULL),
    (1, 8, now() - interval '5 minutes',  NULL),
    (2, 9, now() - interval '1 hour',     now() - interval '40 minutes');
