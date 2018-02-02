CREATE DATABASE LINK vers_Nantes
    CONNECT TO i10a02a identified by __le_mdp__
    using 'db1';

SELECT * from i10a02a.LIVRE@vers_Nantes;

INSERT into EXEMPLAIRE VALUES(0000, 0000);

--Part 2
CREATE MATERIALIZED view Adherent_view
    refresh force
    start with sysdate
    next sysdate+1/1440
    as select * from Adherent;