INSERT INTO shared_room (name, description, capacity) VALUES
    ('Переговорка 1', '2 этаж, проектор', 8),
    ('Переговорка 2', '3 этаж', 4);

INSERT INTO schedule (room_id, days_of_week, start_time, end_time) VALUES
    (1, '{1,2,3,4,5,6,7}', '08:00', '20:00'),
    (2, '{1,2,3,4,5}',     '10:00', '18:00');

-- Слоты на завтра и послезавтра (current_date + 1 = завтра)
INSERT INTO slot (room_id, starts_at, ends_at) VALUES
    (1, current_date + 1 + time '10:00', current_date + 1 + time '10:30'),
    (1, current_date + 1 + time '10:30', current_date + 1 + time '11:00'),
    (1, current_date + 1 + time '11:00', current_date + 1 + time '11:30'),
    (1, current_date + 2 + time '10:00', current_date + 2 + time '10:30'),
    (2, current_date + 1 + time '12:00', current_date + 1 + time '12:30'),
    (2, current_date + 1 + time '12:30', current_date + 1 + time '13:00');

INSERT INTO booking (slot_id, user_id, status, conference_link) VALUES
    (1, 4, 'active',    'https://telemost.yandex.ru/j/1001'),
    (2, 5, 'active',    NULL),
    (3, 8, 'cancelled', NULL),   -- cancelled_at проставит триггер
    (3, 9, 'active',    NULL),
    (5, 6, 'active',    NULL);
