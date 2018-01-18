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
