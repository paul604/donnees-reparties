create or replace TRIGGER Lock_emprunt_Ins_Up
BEFORE INSERT OR UPDATE ON EMPRUNT 
BEGIN
  LOCK TABLE EMPRUNT IN SHARE MODE;
  LOCK TABLE EMPRUNT@vers_Nantes IN SHARE MODE;
END;