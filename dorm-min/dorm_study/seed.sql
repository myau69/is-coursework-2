INSERT INTO study_room (number, name, chair_count) VALUES
    ('1-А', 'Тихая читалка',     12),
    ('2-Б', 'Комната для групп', 6),
    ('3-В', 'Коворкинг',         20);

-- expires_at проставит триггер (started_at + 2 часа)
INSERT INTO study_presence (room_id, user_id, started_at, finished_at) VALUES
    (1, 4, now(),                     NULL),
    (1, 5, now(),                     NULL),
    (2, 6, now(),                     NULL),
    (1, 7, now() - interval '2 days', now() - interval '2 days' + interval '1 hour');
