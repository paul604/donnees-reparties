/*
* Test
*/
--listAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listAdherent(:liste);
PRINT :liste;
commit;
--listEmpruntsForAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listEmpruntsForAdherent(1,:liste);
PRINT :liste;
commit;
--listLivre
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listLivre(:liste);
PRINT :liste;
commit;
--listAdherentRetard
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listAdherentRetard(:liste);
PRINT :liste;
commit;
