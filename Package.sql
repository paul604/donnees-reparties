/*
*  PACKAGE MAJ init 
*/
CREATE OR REPLACE PACKAGE MAJ IS

PROCEDURE CreerAdherent(
    num_ad NUMBER,
    nom_ad VARCHAR2, 
    prenom_ad VARCHAR2, 
    addr_ad VARCHAR2);

TYPE tabChaine is VARRAY(5) of VARCHAR2(10);
PROCEDURE CreerLivre(
    isbn NUMBER, 
    titre VARCHAR2, 
    editeur VARCHAR2, 
    anneeParution NUMBER, 
    tab_auteurs tabChaine, 
    nBE NUMBER, 
    dateDE DATE);
    
TYPE tabNumInv is VARRAY(5) of NUMBER(4);
PROCEDURE CreerExemplaire(tab_numInv tabNumInv, isbn NUMBER);

END;

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
        WHEN OTHERS  THEN
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
    END;

END;


/*
* Test
*/
-- CreerAdherent
EXECUTE MAJ.CreerAdherent(4, 'Mario', 'Super', 'Super Mario Bros');
-- CreerLivre
declare auteurs MAJ.tabChaine;
begin
    auteurs := MAJ.tabChaine();
    auteurs.extend;
    auteurs(1) := '831b';
    auteurs.extend;
    auteurs(2) := '831a';
    MAJ.CreerLivre(666, 'Herobrine, true story', 'Mojang', 2018, auteurs, 0, NULL);
end;
-- CreerExemplaire
declare numInv MAJ.tabNumInv;
begin
    numInv := MAJ.tabNumInv();
    numInv.extend;
    numInv(1) := '1';
    numInv.extend;
    numInv(2) := '2';
    MAJ.CreerExemplaire(numInv, 666);
end;
