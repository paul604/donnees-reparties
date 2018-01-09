/*
*   TD1 
*   Create table
*/
CREATE TABLE Adherent (
    numA NUMBER(4) PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    adresse VARCHAR(20)
);

CREATE TABLE Emprunt (
    numA NUMBER(4),
    dateE DATE,
    dateR DATE,
    PRIMARY KEY (numA, dateE),
    CONSTRAINT FK_numA FOREIGN KEY (numA) REFERENCES Adherent(numA)
);

CREATE TABLE Livre (
    ISBN NUMBER(8),
    titre VARCHAR(20),
    edtiteur VARCHAR(20),
    aneeParution NUMBER(4),
    auteurs VARCHAR(20),
    nbE NUMBER,
    dateDE DATE,
    PRIMARY KEY (ISBN)
);

CREATE TABLE Exemplaire (
    numInv NUMBER,
    ISBN NUMBER(4),
    PRIMARY KEY (numInv),
    CONSTRAINT FK_livre FOREIGN KEY (ISBN) REFERENCES Livre(ISBN)
);

CREATE TABLE ExemplaireEmprunte (
    numInv NUMBER,
    numA NUMBER(4),
    dateE DATE,
    PRIMARY KEY (numInv),
    CONSTRAINT FK_emprunt FOREIGN KEY (numA, dateE) REFERENCES Emprunt(numA, dateE)
);

/*
*   DROP
*/
DROP TABLE ExemplaireEmprunte;
DROP TABLE Exemplaire;
DROP TABLE Livre;
DROP TABLE Emprunt;
DROP TABLE Adherent;


/*
*   Insert
*/
INSERT INTO ADHERENT VALUES (0001, 'nom', 'prenom', 'addr');
INSERT INTO ADHERENT VALUES (0002, 'GLaDOS', 'aperture', 'Michigan');
INSERT INTO ADHERENT VALUES (0003, 'steve', 'craft', 'world');


INSERT INTO LIVRE VALUES (00000042, 'cake is a live', 'apertureS', 2042, '', 0, TO_DATE('01/05/2043','DD/MM/YYYY'));

