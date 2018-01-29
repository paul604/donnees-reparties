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

PROCEDURE SupExemplaire(tab_numInv tabNumInv);

PROCEDURE CreerEmprunt(tab_numInv tabNumInv, numadh NUMBER);

PROCEDURE retoureEx( tab_numInv tabNumInv);

procedure deleteAdh(numAdh NUMBER);

END;
