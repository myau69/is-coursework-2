-- Триггер: нельзя забронировать слот, который уже начался
CREATE FUNCTION check_slot_not_started() RETURNS trigger AS $$
BEGIN
    IF (SELECT starts_at FROM slot WHERE id = NEW.slot_id) <= now() THEN
        RAISE EXCEPTION 'Слот % уже начался', NEW.slot_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER booking_slot_not_started
    BEFORE INSERT ON booking
    FOR EACH ROW EXECUTE FUNCTION check_slot_not_started();


-- Триггер: при отмене брони сам ставит время отмены
CREATE FUNCTION set_cancelled_at() RETURNS trigger AS $$
BEGIN
    IF NEW.status = 'cancelled' AND NEW.cancelled_at IS NULL THEN
        NEW.cancelled_at := now();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER booking_set_cancelled_at
    BEFORE INSERT OR UPDATE ON booking
    FOR EACH ROW EXECUTE FUNCTION set_cancelled_at();
