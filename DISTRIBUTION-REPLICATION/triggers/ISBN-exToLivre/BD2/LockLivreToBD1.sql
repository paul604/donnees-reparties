CREATE OR replace TRIGGER Lock_Livre_toBD1
BEFORE INSERT OR UPDATE ON EXEMPLAIRE
BEGIN
lock table LIVRE@vers_Nantes in share mode;
end;