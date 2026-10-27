DROP TABLE IF EXISTS booking, slot, schedule, shared_room CASCADE;
DROP FUNCTION IF EXISTS check_slot_not_started();
DROP FUNCTION IF EXISTS set_cancelled_at();
