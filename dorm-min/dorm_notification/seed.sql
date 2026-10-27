INSERT INTO announcement (author_id, title, body, audience_mode) VALUES
    (1, 'Отключение горячей воды', 'В четверг с 10:00 до 18:00.', 'all_residents'),
    (1, 'Проверка сигнализации',   'Завтра в 12:00.',             'selected');

-- Второе объявление: комната 1 + отдельно пользователь 9
INSERT INTO announcement_room_target (announcement_id, residential_room_id) VALUES (2, 1);
INSERT INTO announcement_user_target (announcement_id, user_id) VALUES (2, 9);

-- paid_at для 'paid' проставит триггер
INSERT INTO monthly_accommodation_payment_status (user_id, year, month, payment_state, last_successful_check_at) VALUES
    (4, 2026, 10, 'paid',    now()),
    (5, 2026, 10, 'paid',    now()),
    (6, 2026, 10, 'unpaid',  now()),
    (7, 2026, 10, 'unknown', NULL),
    (8, 2026, 10, 'unpaid',  now());

INSERT INTO personal_notification (recipient_id, kind, announcement_id, payment_status_id, study_presence_id, gym_application_id, body) VALUES
    (4,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (5,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (6,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (7,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (8,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (9,  'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (10, 'announcement',       1,    NULL, NULL, NULL, 'Отключение горячей воды'),
    (4,  'announcement',       2,    NULL, NULL, NULL, 'Проверка сигнализации'),
    (5,  'announcement',       2,    NULL, NULL, NULL, 'Проверка сигнализации'),
    (9,  'announcement',       2,    NULL, NULL, NULL, 'Проверка сигнализации'),
    (6,  'payment_reminder',   NULL, 3,    NULL, NULL, 'Проживание за 10.2026 не оплачено'),
    (8,  'payment_reminder',   NULL, 5,    NULL, NULL, 'Проживание за 10.2026 не оплачено'),
    (4,  'gym_decision',       NULL, NULL, NULL, 1,    'Заявка в зал одобрена'),
    (5,  'gym_decision',       NULL, NULL, NULL, 2,    'Заявка в зал отклонена'),
    (4,  'study_confirmation', NULL, NULL, 1,    NULL, 'Вы отметились в учебной комнате на 2 часа');
