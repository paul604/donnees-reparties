create or replace trigger up_val_livre_DB1
    AFTER INSERT ON EXEMPLAIREEMPRUNTE for each row
BEGIN
    UPDATE LIVRE@vers_Nantes
        SET NBE = NBE+1,
            DATEDE = :NEW.dateE,
            LIEUDE = 'Angers'
        WHERE ISBN = (
            SELECT ISBN 
            FROM EXEMPLAIRE 
            where EXEMPLAIRE.NUMINV = :NEW.numInv 
        );
END;