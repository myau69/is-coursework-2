-- Триггер: если сотрудник остановил приём заказов на день, новый заказ не принимается
CREATE FUNCTION check_intake_open() RETURNS trigger AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM laundry_intake_closure
               WHERE business_date = NEW.received_at::date
                 AND stopped_at <= NEW.received_at) THEN
        RAISE EXCEPTION 'Приём заказов на % закрыт', NEW.received_at::date;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_intake_open
    BEFORE INSERT ON laundry_order
    FOR EACH ROW EXECUTE FUNCTION check_intake_open();
