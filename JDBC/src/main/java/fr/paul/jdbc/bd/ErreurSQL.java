package fr.paul.jdbc.bd;

/**
 * Created by Paul on 06/02/18.
 */
public class ErreurSQL extends Exception {
    private int codeErreur;
    private String msgErreur;

    public ErreurSQL(int i, String msg) {
        codeErreur = i;
        msgErreur = msg;
        switch (i) {
            case 0:
                msgErreur = "Connection impossible";
                break;
            case 20001:
                msgErreur = "L'employe existe déjà ( le numéro )";
                break;
        }
    }

    public void afficher() {
        System.out.println(msgErreur) ;
    }

}
