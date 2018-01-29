create or replace TRIGGER Lock_Exemplaire_Ins_Up
BEFORE INSERT OR UPDATE ON Exemplaire 
BEGIN
  LOCK TABLE Exemplaire IN SHARE MODE;
  LOCK TABLE Exemplaire@vers_Angers IN SHARE MODE;
END;