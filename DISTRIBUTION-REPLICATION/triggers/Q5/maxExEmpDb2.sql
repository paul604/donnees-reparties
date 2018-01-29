create or replace TRIGGER max_exem_emp
    AFTER INSERT on EXEMPLAIREEMPRUNTE
    declare
        ligne_exem_emp ADHERENT@vers_Nantes%rowtype;
begin
    SELECT * into ligne_exem_emp FROM ADHERENT@vers_Nantes 
        WHERE (
            (SELECT COUNT(*) FROM EXEMPLAIREEMPRUNTE exN
                WHERE ADHERENT.NUMA=exN.NUMA)
            +
            (SELECT COUNT(*) FROM EXEMPLAIREEMPRUNTE@vers_Nantes exA
                WHERE ADHERENT.NUMA=exA.NUMA)
        )>5;
    raise_application_error (-20001, 'un adhérant a emprunté plus de 5 exemplaires');
    exception
        when no_data_found then null;
        when too_many_rows then
    raise_application_error (-20002, 'des adhérants ont emprunté plus de 5 exemplaires');
end;