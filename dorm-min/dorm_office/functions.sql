-- Триггер: если человек уже вышел из очереди, эту запись менять нельзя
CREATE FUNCTION check_queue_not_finished() RETURNS trigger AS $$
BEGIN
    IF OLD.finished_at IS NOT NULL THEN
        RAISE EXCEPTION 'Запись очереди % уже закрыта', OLD.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER queue_not_finished
    BEFORE UPDATE ON office_queue_presence
    FOR EACH ROW EXECUTE FUNCTION check_queue_not_finished();
