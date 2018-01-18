/*
*  PACKAGE Lecture init
*/
CREATE OR REPLACE PACKAGE Lecture IS

TYPE liste_Cursor IS REF CURSOR;
PROCEDURE listAdherent(liste out liste_Cursor);

PROCEDURE listEmpruntsForAdherent(idAdh NUMBER, liste out liste_Cursor);

PROCEDURE listLivre(liste out liste_Cursor);

PROCEDURE listAdherentRetard(liste out liste_Cursor);

END;
