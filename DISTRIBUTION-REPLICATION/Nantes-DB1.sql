CREATE DATABASE LINK vers_Angers
    CONNECT TO i10a02abis identified by __le_mdp__
    using 'db2';

SELECT * from i10a02abis.EXEMPLAIRE@vers_Angers;

--Part 2
CREATE MATERIALIZED view log on Adherent;
