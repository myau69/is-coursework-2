-- Триггер: пропуск в зал действует ровно 1 год — срок ставится сам
CREATE FUNCTION set_permit_expiration() RETURNS trigger AS $$
BEGIN
    NEW.expires_at := NEW.issued_at + interval '1 year';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER permit_set_expiration
    BEFORE INSERT ON gym_access_permit
    FOR EACH ROW EXECUTE FUNCTION set_permit_expiration();


-- Триггер: пропуск можно выдать только по одобренной заявке
CREATE FUNCTION check_application_approved() RETURNS trigger AS $$
BEGIN
    IF (SELECT status FROM gym_access_application WHERE id = NEW.application_id) <> 'approved' THEN
        RAISE EXCEPTION 'Заявка % не одобрена', NEW.application_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER permit_requires_approval
    BEFORE INSERT ON gym_access_permit
    FOR EACH ROW EXECUTE FUNCTION check_application_approved();
