/*
* Test
*/
--listAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listAdherent(:liste);
PRINT :liste;
--listEmpruntsForAdherent
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listEmpruntsForAdherent(1,:liste);
PRINT :liste;
--listLivre
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listLivre(:liste);
PRINT :liste;
--listAdherentRetard
VARIABLE liste REFCURSOR;
EXECUTE Lecture.listAdherentRetard(:liste);
PRINT :liste;
