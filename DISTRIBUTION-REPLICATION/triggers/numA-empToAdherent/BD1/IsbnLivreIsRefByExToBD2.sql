CREATE OR replace TRIGGER  Isbn_livre_isRefBy_ex_to_BD2
    AFTER DELETE ON LIVRE
    DECLARE
    rec_ex EXEMPLAIRE@vers_Angers%rowtype;
begin
    SELECT * INTO rec_ex 
        FROM EXEMPLAIRE@vers_Angers
        WHERE ISBN not IN
            (SELECT LIVRE.ISBN FROM LIVRE);
    raise_application_error (-20202,'viol de fk ISBN. Enfant dans BD2'); 
EXCEPTION
    WHEN no_data_found then NULL;
    WHEN too_many_rows then
        raise_application_error (-20202,'viol de fk ISBN. Enfants dans BD2');
END;