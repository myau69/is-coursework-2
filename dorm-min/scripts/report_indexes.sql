-- Индексы текущей базы (pgAdmin: Query Tool → Open File → F5)
SELECT i.tablename AS "таблица",
       i.indexname AS "индекс",
       CASE c.contype WHEN 'p' THEN 'PRIMARY KEY'
                      WHEN 'u' THEN 'UNIQUE'
                      WHEN 'x' THEN 'EXCLUDE'
                      ELSE 'создан вручную' END AS "происхождение",
       pg_get_indexdef(format('%I.%I', i.schemaname, i.indexname)::regclass) AS "определение"
FROM pg_indexes i
LEFT JOIN pg_constraint c
       ON c.conindid = format('%I.%I', i.schemaname, i.indexname)::regclass
      AND c.contype IN ('p', 'u', 'x')
WHERE i.schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY c.contype IS NOT NULL, 1, 2;

