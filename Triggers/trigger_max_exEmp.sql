/*
* max ExemplaireEmprunte 5 by adherent
*/
create or replace TRIGGER max_exEmp
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
