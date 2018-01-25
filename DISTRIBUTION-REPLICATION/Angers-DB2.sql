CREATE DATABASE LINK vers_Nantes
    CONNECT TO i10a02a identified by __le_mdp__
    using 'db1';

SELECT * from i10a02a.LIVRE@vers_Nantes;
