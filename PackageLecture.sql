/*
*  PACKAGE Lecture init 
*/
CREATE OR REPLACE PACKAGE Lecture IS

TYPE liste_adh IS REF CURSOR;
PROCEDURE listAdherent(liste out liste_adh);

END;

/*
* body Lecture
*/
create or replace PACKAGE BODY Lecture IS