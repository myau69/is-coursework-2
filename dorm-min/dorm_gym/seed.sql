INSERT INTO safety_instruction_version (version, content, published_at, published_by) VALUES
    ('2025.1', 'Правила зала: разминка, страховка, свободные веса только вдвоём.', now() - interval '400 days', 2),
    ('2026.1', 'Правила зала v2: сменная обувь, журнал посещений.',              now() - interval '30 days',  2);

INSERT INTO safety_acknowledgement (user_id, instruction_version_id) VALUES
    (4, 2), (5, 2), (6, 2), (7, 2);

INSERT INTO gym_access_application (user_id, certificate_ref, acknowledgement_id, status, reviewed_by, reviewed_at, decision_note) VALUES
    (4, 'certificates/4.pdf', 1, 'approved',  2,    now(), NULL),
    (5, 'certificates/5.jpg', 2, 'rejected',  2,    now(), 'Справка без печати'),
    (6, 'certificates/6.pdf', 3, 'submitted', NULL, NULL,  NULL),
    (7, 'certificates/7.pdf', 4, 'submitted', NULL, NULL,  NULL);

-- expires_at проставит триггер (issued_at + 1 год)
INSERT INTO gym_access_permit (application_id) VALUES (1);
