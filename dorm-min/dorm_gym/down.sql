DROP TABLE IF EXISTS gym_access_permit, gym_access_application,
                     safety_acknowledgement, safety_instruction_version CASCADE;
DROP FUNCTION IF EXISTS set_permit_expiration();
DROP FUNCTION IF EXISTS check_application_approved();
