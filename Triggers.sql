/*
* trigger sup Emprunt quans le dernier ExemplaireEmprunte a ete sup
*/
create or replace trigger sup_exem
    AFTER DELETE ON EXEMPLAIREEMPRUNTE
BEGIN
    DELETE FROM Emprunt WHERE (Emprunt.NUMA, Emprunt.DATEE) NOT IN
        (SELECT EXEMPLAIREEMPRUNTE.NUMA, EXEMPLAIREEMPRUNTE.DATEE FROM EXEMPLAIREEMPRUNTE);
END;



/*
* max ExemplaireEmprunte 5 by adherent
*/
create or replace TRIGGER max_exem_emp
    AFTER INSERT on EXEMPLAIREEMPRUNTE
    declare
        ligne_exem_emp ADHERENT%rowtype;
begin
    SELECT * into ligne_exem_emp FROM ADHERENT 
        WHERE (SELECT COUNT(*) from EXEMPLAIREEMPRUNTE 
        WHERE ADHERENT.NUMA=EXEMPLAIREEMPRUNTE.NUMA)>5;
    raise_application_error (-20001, 'un adhérant a emprunté plus de 5 exemplaires');
    exception
        when no_data_found then null;
        when too_many_rows then
    raise_application_error (-20002, 'des adhérants ont emprunté plus de 5 exemplaires');
end;

/*
* up nbE and dateDE in Livre where add in ExemplaireEmprunte
*/
create or replace trigger up_val_livre
    AFTER INSERT ON EXEMPLAIREEMPRUNTE for each row
BEGIN
    UPDATE LIVRE
        SET NBE = NBE+1,
            DATEDE = :NEW.dateE
        WHERE ISBN = (
            SELECT ISBN 
            FROM EXEMPLAIRE 
            where EXEMPLAIRE.NUMINV = :NEW.numInv 
        );
END;
