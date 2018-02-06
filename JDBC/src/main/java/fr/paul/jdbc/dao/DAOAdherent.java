package fr.paul.jdbc.dao;

import fr.paul.jdbc.bd.SessionOracle;
import fr.paul.jdbc.bean.Adherent;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by Paul on 06/02/18.
 */
public class DAOAdherent {

    private Connection conn;

    public DAOAdherent(SessionOracle sessionOracle) {
        this.conn = sessionOracle.getConnection();
    }

    public ArrayList<Adherent> read() {
        ArrayList<Adherent> adherents = new ArrayList<Adherent>();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * from ADHERENT");
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                adherents.add(new Adherent(resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4)));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adherents;
    }

    public void creerAdh(int numA, String nom, String prenom, String addr) {
        try {
            CallableStatement callableStatement = conn.prepareCall("call MAJ.CreerAdherent(?,?,?,?)");
            callableStatement.setInt(1, numA);
            callableStatement.setString(2, nom);
            callableStatement.setString(3, prenom);
            callableStatement.setString(4, addr);

            callableStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAdh(int numA) {
        try {
            CallableStatement callableStatement = conn.prepareCall("call MAJ.deleteAdh(?)");
            callableStatement.setInt(1, numA);

            callableStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
