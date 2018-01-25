CREATE OR replace TRIGGER Isbn_ex_ref_livre_to_BD1
    AFTER INSERT OR UPDATE on EXEMPLAIRE
    DECLARE
    rec_ex EXEMPLAIRE%rowtype;
begin   
    SELECT * INTO rec_ex
        FROM EXEMPLAIRE 
        WHERE ISBN not IN
            (SELECT LIVRE.ISBN FROM LIVRE@vers_Nantes);
    raise_application_error (-20202,'viol de fk ISBN'); 
EXCEPTION
    WHEN no_data_found then NULL;
    WHEN too_many_rows then
        raise_application_error (-20202,'viol de fk ISBN');
END;