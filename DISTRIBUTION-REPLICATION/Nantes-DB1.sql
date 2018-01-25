CREATE DATABASE LINK vers_Angers
    CONNECT TO i10a02abis identified by __le_mdp__
    using 'db2';

SELECT * from i10a02a.LIVRE@vers_Nantes;
