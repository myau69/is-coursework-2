INSERT INTO laundry_service (code, name) VALUES
    ('wash', 'Стирка'),
    ('dry',  'Сушка');

-- Тариф 1 — старая цена стирки, 2 — текущая стирка, 3 — сушка
INSERT INTO laundry_tariff (service_id, price, valid_from, valid_until) VALUES
    (1, 150, now() - interval '200 days', now() - interval '60 days'),
    (1, 180, now() - interval '60 days',  NULL),
    (2, 100, now() - interval '200 days', NULL);

-- Приём закрыт вчера в 19:00
INSERT INTO laundry_intake_closure (stopped_by, business_date, stopped_at) VALUES
    (3, current_date - 1, current_date - 1 + time '19:00');

INSERT INTO laundry_order (user_id, received_at, contact_phone, declared_paid_amount) VALUES
    (4, current_date - 3 + time '10:15', '+79210000004', 280),
    (5, current_date - 2 + time '12:40', '+79210000005', 180),
    (6, current_date - 1 + time '09:30', '+79210000006', 460),
    (7, current_date - 1 + time '18:50', '+79210000007', 180),
    (8, now(),                           '+79210000008', 100);

INSERT INTO laundry_batch (order_id, container_number) VALUES
    (1, '1'),
    (2, '1'),
    (3, '1'), (3, '2'),
    (4, '1'),
    (5, '1');

INSERT INTO laundry_batch_service (batch_id, tariff_id) VALUES
    (1, 2), (1, 3),   -- стирка + сушка
    (2, 2),
    (3, 2), (3, 3),
    (4, 2), (4, 3),
    (5, 2),
    (6, 3);

INSERT INTO laundry_rejection_report (user_id, occurred_at) VALUES
    (5, now() - interval '26 hours'),
    (6, now() - interval '27 hours');
