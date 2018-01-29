CREATE OR replace TRIGGER Lock_ex_toBD2
BEFORE DELETE ON LIVRE
BEGIN
lock table EXEMPLAIRE@vers_Angers in share mode;
end;