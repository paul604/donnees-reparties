CREATE OR replace TRIGGER NumA_Emp_ref_Adh_to_BD1
    AFTER INSERT OR UPDATE on EMPRUNT
    DECLARE
    rec_emp EMPRUNT%rowtype;
begin   
    SELECT * INTO rec_emp
        FROM EMPRUNT 
        WHERE NUMA not IN
            (SELECT ADHERENT.NUMA FROM ADHERENT@vers_Nantes);
    raise_application_error (-20202,'viol de fk ISBN'); 
EXCEPTION
    WHEN no_data_found then NULL;
    WHEN too_many_rows then
        raise_application_error (-20202,'viol de fk ISBN');
END;