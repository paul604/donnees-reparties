CREATE OR replace TRIGGER Lock_emp_toBD2
BEFORE DELETE ON ADHERENT
BEGIN
lock table EMPRUNT@vers_Angers in share mode;
end;
