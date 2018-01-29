CREATE OR replace TRIGGER Lock_Adh_toBD1
    BEFORE INSERT OR UPDATE ON EMPRUNT
BEGIN
    lock table ADHERENT@vers_Nantes in share mode;
end;