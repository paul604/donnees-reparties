/*
* body MAJ
*/
create or replace PACKAGE BODY MAJ IS

PROCEDURE CreerAdherent(num_ad NUMBER, nom_ad VARCHAR2, prenom_ad VARCHAR2, addr_ad VARCHAR2) IS
    BEGIN
        SET TRANSACTION READ WRITE;
        INSERT INTO ADHERENT VALUES (num_ad, nom_ad, prenom_ad, addr_ad);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -0001 THEN
                RollBack;
                RAISE_APPLICATION_ERROR(-20001, 'adherent existe déjà');
            elsIf SQLCODE = -1438 THEN
                RollBack;
                RAISE_APPLICATION_ERROR(-20002, 'pb table number');
            elsIf SQLCODE = -12899 THEN
                RollBack;
                RAISE_APPLICATION_ERROR(-20004, 'pb taille chaine de caractère');
            else
                RollBack;
                RAISE_APPLICATION_ERROR(-20005, 'error' || SQLCODE);
            END IF;
    END;

PROCEDURE CreerLivre(isbn NUMBER, titre VARCHAR2, editeur VARCHAR2, anneeParution NUMBER,
        tab_auteurs tabChaine, nBE NUMBER, dateDE DATE) IS
    auteurs LIVRE.AUTEURS%TYPE;
    BEGIN
        SET TRANSACTION READ WRITE;
        auteurs := '';
        FOR i IN tab_auteurs.first .. tab_auteurs.last LOOP
            auteurs := auteurs || '|' || tab_auteurs(i);
        END LOOP;
        INSERT INTO LIVRE VALUES(isbn, titre, editeur, anneeParution, auteurs, nBE, dateDE);
        COMMIT;
    END;


PROCEDURE CreerExemplaire(tab_numInv tabNumInv, isbn NUMBER) IS
    numInv EXEMPLAIRE.NUMINV%TYPE;
    BEGIN
        SET TRANSACTION READ WRITE;
        numInv := 0;
        FOR i IN tab_numInv.first .. tab_numInv.last LOOP
            numInv := isbn || tab_numInv(i);
            INSERT INTO EXEMPLAIRE VALUES(numInv, isbn);
        END LOOP;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -0001 THEN
                RollBack;
                RAISE_APPLICATION_ERROR(-20001, numInv || ' existe déjà');
            END IF;
    END;

PROCEDURE SupExemplaire(tab_numInv tabNumInv) IS
    numInvSup EXEMPLAIRE.NUMINV%TYPE;
    Pas_exemplaire EXCEPTION;
    BEGIN
        SET TRANSACTION READ WRITE;
        numInvSup := 0;
        FOR i IN tab_numInv.first .. tab_numInv.last LOOP
            numInvSup := tab_numInv(i);
            DELETE FROM EXEMPLAIRE WHERE EXEMPLAIRE.numInv = numInvSup;
            IF SQL%NOTFOUND then
                RAISE Pas_exemplaire;
            END IF;
        END LOOP;
        COMMIT;
    EXCEPTION
        WHEN Pas_exemplaire THEN
            RollBack;
            RAISE_APPLICATION_ERROR(-20006, numInvSup || ' pas trouvée');
    END;
    
PROCEDURE CreerEmprunt(tab_numInv tabNumInv, numadh NUMBER) is
    numInv EXEMPLAIRE.NUMINV%TYPE;
    BEGIN
        SET TRANSACTION READ WRITE;
        numInv := 0;
        INSERT INTO EMPRUNT VALUES ( numadh, SYSDATE, SYSDATE+15);
        FOR i IN tab_numInv.first .. tab_numInv.last LOOP
            numInv := tab_numInv(i);
            INSERT INTO EXEMPLAIREEMPRUNTE VALUES(numInv, numadh,SYSDATE);
        END LOOP;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -0001 THEN 
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20001, numInv || ' existe déjà !!');
            END IF;
    END;
    
PROCEDURE retoureEx( tab_numInv tabNumInv) IS    
    numInv EXEMPLAIRE.NUMINV%TYPE;
    Pas_exemplaire EXCEPTION;
    BEGIN
        SET TRANSACTION READ WRITE;
        numInv := 0;
        FOR i IN tab_numInv.first .. tab_numInv.last LOOP
            numInv := tab_numInv(i);
            DELETE FROM EXEMPLAIREEMPRUNTE 
                WHERE(EXEMPLAIREEMPRUNTE.NUMINV = numInv);
            IF SQL%NOTFOUND then
                RAISE Pas_exemplaire;
            END IF;
        END LOOP; 
        COMMIT;
    EXCEPTION
        WHEN Pas_exemplaire THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, numInv || ' pas trouvée');
    END;

PROCEDURE deleteAdh(numAdh NUMBER) is
    BEGIN
        SET TRANSACTION READ WRITE;
        DELETE FROM EXEMPLAIREEMPRUNTE WHERE numA=numAdh;
        DELETE FROM EMPRUNT WHERE numA=numAdh;
        DELETE FROM ADHERENT WHERE numA=numAdh;
        COMMIT;
    END;

END;
