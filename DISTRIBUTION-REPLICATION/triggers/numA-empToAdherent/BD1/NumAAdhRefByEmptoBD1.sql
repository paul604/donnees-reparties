CREATE OR replace TRIGGER  NumA_Adh_refBy_Emp_to_BD1
    AFTER DELETE ON ADHERENT
    DECLARE
    rec_emp EMPRUNT@vers_Angers%rowtype;
begin
    SELECT * INTO rec_emp
        FROM EMPRUNT@vers_Angers
        WHERE NUMA not IN
            (SELECT ADHERENT.NUMA FROM ADHERENT);
    raise_application_error (-20203,'viol de fk NumA.');
EXCEPTION
    WHEN no_data_found then NULL;
    WHEN too_many_rows then
        raise_application_error (-20203,'viol de fk NumA.');
END;
