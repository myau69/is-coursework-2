-- Триггер: когда оплата становится 'paid', сам ставит время оплаты
CREATE FUNCTION set_paid_at() RETURNS trigger AS $$
BEGIN
    IF NEW.payment_state = 'paid' AND NEW.paid_at IS NULL THEN
        NEW.paid_at := now();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER payment_set_paid_at
    BEFORE INSERT OR UPDATE ON monthly_accommodation_payment_status
    FOR EACH ROW EXECUTE FUNCTION set_paid_at();
