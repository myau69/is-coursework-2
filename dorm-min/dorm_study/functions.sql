-- Триггер: отметка в учебной комнате действует 2 часа — срок ставится сам
CREATE FUNCTION set_presence_expiration() RETURNS trigger AS $$
BEGIN
    NEW.expires_at := NEW.started_at + interval '2 hours';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER presence_set_expiration
    BEFORE INSERT ON study_presence
    FOR EACH ROW EXECUTE FUNCTION set_presence_expiration();
