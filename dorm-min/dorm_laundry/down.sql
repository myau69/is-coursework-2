DROP TABLE IF EXISTS laundry_batch_service, laundry_batch, laundry_order, laundry_tariff,
                     laundry_service, laundry_rejection_report, laundry_intake_closure CASCADE;
DROP FUNCTION IF EXISTS check_intake_open();
