-- Триггер: email всегда хранится маленькими буквами,
-- чтобы Ivanov@itmo.ru и ivanov@itmo.ru не считались разными пользователями
CREATE FUNCTION email_to_lower() RETURNS trigger AS $$
BEGIN
    NEW.email := lower(NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER app_user_email_lower
    BEFORE INSERT OR UPDATE ON app_user
    FOR EACH ROW EXECUTE FUNCTION email_to_lower();
