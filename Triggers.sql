/*
* trigger sup Emprunt quans le dernier ExemplaireEmprunte a ete sup
*/
create or replace trigger sup_emprunt_after_sup_last_ExemplaireEmprunte 
    AFTER DELETE ON EXEMPLAIREEMPRUNTE
BEGIN
    delete from Emprunt where (Emprunt.NUMA, Emprunt.DATEE) not in
        (select (EXEMPLAIREEMPRUNTE.NUMA, EXEMPLAIREEMPRUNTE.DATEE) from EXEMPLAIREEMPRUNTE);
END;
