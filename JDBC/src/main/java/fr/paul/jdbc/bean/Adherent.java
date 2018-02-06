package fr.paul.jdbc.bean;

/**
 * Created by Paul on 06/02/18.
 */
public class Adherent {
    private int numAdh;
    private String nom,
            prenom,
            addr;

    public Adherent(int numAdh, String nom, String prenom, String addr) {
        this.numAdh = numAdh;
        this.nom = nom;
        this.prenom = prenom;
        this.addr = addr;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getAddr() {
        return addr;
    }

    public int getNumAdh() {
        return numAdh;
    }
}
