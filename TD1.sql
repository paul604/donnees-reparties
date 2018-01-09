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

