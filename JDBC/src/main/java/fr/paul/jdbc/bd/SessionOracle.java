package fr.paul.jdbc.bd;

import java.sql.*;

public class SessionOracle  {
    static Connection conn;


    private CallableStatement callstmt;

    public SessionOracle (String user, String passwd) throws ErreurSQL {
        try {

            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            conn = DriverManager.getConnection("jdbc:oracle:thin:@soracle3:1521:DB1",user, passwd);



            System.out.println("connexion réussi");
        }
        catch(SQLException e)
        {
            System.out.println("connexion échoué");

            conn = null;
            throw ( new ErreurSQL(e.getErrorCode(), e.getMessage()));
        }
    }

    public Connection getConnection()
    {
        return conn;
    }

}
