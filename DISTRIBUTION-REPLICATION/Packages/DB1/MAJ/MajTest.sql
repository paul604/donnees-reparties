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
    numInv.extend;
    numInv(3) := '3';
    MAJ.CreerExemplaire(numInv, 666);
end;
-- SupExemplaire
declare numInv MAJ.tabNumInv;
begin
    numInv := MAJ.tabNumInv();
    numInv.extend;
    numInv(1) := 6661;
    numInv.extend;
    numInv(2) := 6662;
    MAJ.SupExemplaire(numInv);
end;
