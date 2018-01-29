create or replace TRIGGER Lock_ExeEmp_Ins_Up
BEFORE INSERT OR UPDATE ON ExemplaireEmprunte 
BEGIN
  LOCK TABLE ExemplaireEmprunte IN SHARE MODE;
  LOCK TABLE ExemplaireEmprunte@vers_Nantes IN SHARE MODE;
END;