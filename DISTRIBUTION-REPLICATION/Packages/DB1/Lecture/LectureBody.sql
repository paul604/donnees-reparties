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
        OPEN liste FOR select * from(
            SELECT Exemplaire.NUMINV, Livre.titre
                FROM Livre, EXEMPLAIRE
                WHERE Livre.ISBN = EXEMPLAIRE.ISBN
                    AND EXEMPLAIRE.numInv IN (
                        SELECT numInv
                        FROM ExemplaireEmprunte
                        WHERE numA = idAdh
                    )

            Union all

            SELECT exA.NUMINV, Livre.titre
                FROM Livre, EXEMPLAIRE@vers_Angers exA
                WHERE Livre.ISBN = exA.ISBN
                    AND exA.numInv IN (
                        SELECT numInv
                        FROM ExemplaireEmprunte@vers_Angers
                        WHERE numA = idAdh
                    )
        );
        COMMIT;
    END;

PROCEDURE listLivre(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR
            SELECT ISBN, Titre,
                (SELECT COUNT(*) from(
                    select numinv
                    FROM EXEMPLAIRE ex
                    WHERE ex.ISBN = liv.ISBN

                union all

                    select numinv
                    FROM EXEMPLAIRE@vers_Angers ex
                    WHERE ex.ISBN = liv.ISBN
                )) nb_exemplaire,
                (SELECT COUNT(*) FROM (
                    select numinv 
                    From EXEMPLAIRE ex
                    WHERE ex.ISBN = liv.ISBN
                        AND ex.NUMINV NOT IN (
                            SELECT NUMINV
                            FROM EXEMPLAIREEMPRUNTE exEp
                        )

                    union all

                    select numinv 
                    From EXEMPLAIRE@vers_Angers ex
                    WHERE ex.ISBN = liv.ISBN
                        AND ex.NUMINV NOT IN (
                            SELECT NUMINV
                            FROM EXEMPLAIREEMPRUNTE@vers_Angers exEp
                        )
                )) nb_libre
            FROM Livre liv;
        COMMIT;
    END;

PROCEDURE listAdherentRetard(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR
            SELECT *
                FROM (
                    select adh.numA, adh.NOM, emp.DATEE, exEmp.NUMINV, liv.TITRE
                    From ADHERENT adh,
                    EMPRUNT emp,
                    EXEMPLAIREEMPRUNTE exEmp,
                    EXEMPLAIRE ex,
                    LIVRE liv
                    WHERE adh.NUMA = emp.NUMA
                        AND emp.DATER < SYSDATE
                        AND emp.NUMA = exEmp.NUMA
                        AND emp.dateE = exEmp.dateE
                        AND exEmp.NUMINV = ex.NUMINV
                        AND ex.ISBN = liv.ISBN
                
                union all
                
                    select adh.numA, adh.NOM, emp.DATEE, exEmp.NUMINV, liv.TITRE
                    From ADHERENT adh,
                    EMPRUNT@vers_Angers emp,
                    EXEMPLAIREEMPRUNTE@vers_Angers exEmp,
                    EXEMPLAIRE@vers_Angers ex,
                    LIVRE liv
                    WHERE adh.NUMA = emp.NUMA
                        AND emp.DATER < SYSDATE
                        AND emp.NUMA = exEmp.NUMA
                        AND emp.dateE = exEmp.dateE
                        AND exEmp.NUMINV = ex.NUMINV
                        AND ex.ISBN = liv.ISBN
                )
                
        COMMIT;
        END;
END;
