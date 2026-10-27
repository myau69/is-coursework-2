```bash
bash scripts/db.sh reset
createdb dorm_laundry
psql -d dorm_laundry -f dorm_laundry/up.sql
psql -d dorm_laundry -f dorm_laundry/functions.sql
psql -d dorm_laundry -f dorm_laundry/seed.sql
```
