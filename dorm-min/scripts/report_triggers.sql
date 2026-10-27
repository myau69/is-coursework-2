SELECT c.relname AS "таблица",
       t.tgname  AS "триггер",
       p.proname AS "функция",
       pg_get_triggerdef(t.oid) AS "определение"
FROM pg_trigger t
JOIN pg_class c     ON c.oid = t.tgrelid
JOIN pg_proc p      ON p.oid = t.tgfoid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE NOT t.tgisinternal
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY 1, 2;
