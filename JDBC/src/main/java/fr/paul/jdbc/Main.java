package fr.paul.jdbc;

import fr.paul.jdbc.bd.ErreurSQL;
import fr.paul.jdbc.bd.SessionOracle;
import fr.paul.jdbc.dao.DAOAdherent;

import java.sql.SQLException;

/**
 * Created by Paul on 06/02/18.
 */
public class Main {
    public static void main(String ... args) throws ErreurSQL, SQLException {
        SessionOracle sessionOracle = new SessionOracle("i10a02a", "oracle2mdp");

        DAOAdherent daoAdherent = new DAOAdherent(sessionOracle);
        System.out.println(daoAdherent.read());
        daoAdherent.creerAdh(10, "test", "test", "test");
        System.out.println(daoAdherent.read());
        daoAdherent.deleteAdh(10);
        System.out.println(daoAdherent.read());

        sessionOracle.getConnection().close();
    }
}
