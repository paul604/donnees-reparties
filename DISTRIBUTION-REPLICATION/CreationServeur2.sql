/*
*   TD1 
*   DROP
*/
DROP TABLE ExemplaireEmprunte;
DROP TABLE Exemplaire;
DROP TABLE Emprunt;

/*
*   Create table
*/
CREATE TABLE Emprunt (
    numA NUMBER(4),
    dateE DATE,
    dateR DATE,
    PRIMARY KEY (numA, dateE)
);

CREATE TABLE Exemplaire (
    numInv NUMBER,
    ISBN NUMBER(4),
    PRIMARY KEY (numInv)
);

CREATE TABLE ExemplaireEmprunte (
    numInv NUMBER,
    numA NUMBER(4),
    dateE DATE,
    PRIMARY KEY (numInv),
    CONSTRAINT FK_exemplaire FOREIGN KEY (numInv) REFERENCES Exemplaire(numInv),
    CONSTRAINT FK_emprunt FOREIGN KEY (numA, dateE) REFERENCES Emprunt(numA, dateE)
);

/*
*   Insert
*/
INSERT INTO EXEMPLAIRE VALUES (000000423, 00000042);
INSERT INTO EXEMPLAIRE VALUES (000000424, 00000042);

INSERT INTO EMPRUNT VALUES (0001, TO_DATE('01/05/2003','DD/MM/YYYY'), TO_DATE('01/06/2003','DD/MM/YYYY'));

INSERT INTO EXEMPLAIREEMPRUNTE VALUES (000000423, 0001, TO_DATE('01/05/2003','DD/MM/YYYY'));

COMMIT;