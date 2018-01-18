/*
*  PACKAGE Lecture init 
*/
CREATE OR REPLACE PACKAGE Lecture IS

TYPE liste_Cursor IS REF CURSOR;
PROCEDURE listAdherent(liste out liste_Cursor);

PROCEDURE listEmpruntsForAdherent(idAdh NUMBER, liste out liste_Cursor);

PROCEDURE listLivre(liste out liste_Cursor);

END;

/*
* body Lecture
*/
create or replace PACKAGE BODY Lecture IS

PROCEDURE listAdherent(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR SELECT * FROM ADHERENT;
        COMMIT;
    END;

PROCEDURE listEmpruntsForAdherent(idAdh NUMBER, liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR 
            SELECT Exemplaire.NUMINV, Livre.titre
                FROM Livre, EXEMPLAIRE
                WHERE Livre.ISBN = EXEMPLAIRE.ISBN
                    AND EXEMPLAIRE.numInv IN (
                        SELECT numInv 
                        FROM ExemplaireEmprunte
                        WHERE numA = idAdh
                    );
        COMMIT;
    END; 

PROCEDURE listLivre(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR 
            SELECT ISBN, Titre,
                (SELECT COUNT(*) 
                    FROM EXEMPLAIRE ex 
                    WHERE ex.ISBN = liv.ISBN
                ) nb_exemplaire,
                (SELECT COUNT(*)
                    FROM EXEMPLAIRE ex
                    WHERE ex.ISBN = liv.ISBN
                        AND ex.NUMINV NOT IN (
                            SELECT NUMINV 
                            FROM EXEMPLAIREEMPRUNTE exEp
                        )
                ) nb_libre
            FROM Livre liv;
        COMMIT;
    END; 

END;

/*
* Test
*/
--listAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listAdherent(:liste);
PRINT :liste;
--listEmpruntsForAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listEmpruntsForAdherent(3,:liste);
PRINT :liste;
--listLivre
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listLivre(:liste);
PRINT :liste;
