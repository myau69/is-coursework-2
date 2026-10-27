INSERT INTO residential_room (number) VALUES
    ('101'), ('102'), ('201'), ('202'), ('301'), ('302');

INSERT INTO permission (code, name) VALUES
    ('permission.manage',      'Выдача прав'),
    ('announcement.publish',   'Публикация объявлений'),
    ('gym.application.review', 'Рассмотрение заявок в зал'),
    ('laundry.staff',          'Работа в прачечной');

-- id пользователей: 1..10 (на них ссылаются другие базы через user_id)
INSERT INTO app_user (isu, email, password_hash, full_name, phone, residential_room_id) VALUES
    (NULL,     'admin@dorm.itmo.ru',    'hash', 'Ирина Комендантова', '+79110000001', NULL),
    ('200001', 'trainer@dorm.itmo.ru',  'hash', 'Пётр Тренеров',      '+79110000002', NULL),
    (NULL,     'laundry@dorm.itmo.ru',  'hash', 'Ольга Прачкина',     '+79110000003', NULL),
    ('335001', 'Ivanov@niuitmo.ru',     'hash', 'Алексей Иванов',     '+79210000004', 1),
    ('335002', 'petrova@niuitmo.ru',    'hash', 'Мария Петрова',      '+79210000005', 1),
    ('335003', 'sidorov@niuitmo.ru',    'hash', 'Дмитрий Сидоров',    NULL,           2),
    ('335004', 'kuznetsova@niuitmo.ru', 'hash', 'Анна Кузнецова',     '+79210000007', 3),
    ('335005', 'smirnov@niuitmo.ru',    'hash', 'Егор Смирнов',       '+79210000008', 4),
    ('335006', 'volkova@niuitmo.ru',    'hash', 'София Волкова',      NULL,           5),
    ('335007', 'morozov@niuitmo.ru',    'hash', 'Никита Морозов',     '+79210000010', 6);

INSERT INTO user_permission (user_id, permission_id, granted_by) VALUES
    (1, 1, NULL),
    (1, 2, NULL),
    (2, 3, 1),
    (3, 4, 1);
