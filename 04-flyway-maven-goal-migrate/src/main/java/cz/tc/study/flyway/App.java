package cz.tc.study.flyway;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Simple database example - hsqldb
 */
public class App 
{
    public static void main( String[] args ) throws SQLException
    {
        String db = "jdbc:hsqldb:file:target/db/flyway_sample;shutdown=true";

        try (Connection connection = DriverManager.getConnection(db, "sa", null);
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM PERSON");) {
            ResultSet rs = preparedStatement.executeQuery();

            System.out.println("-------------------------");
            System.out.println("PERSON table:");
            System.out.println("-------------------------");
            while (rs.next()) {
                int id = rs.getInt("ID");
                String name = rs.getString("NAME");
                System.out.println(id + ", " + name);
                if(!rs.isLast())System.out.println("-----------");
            }
            System.out.println("-------------------------");
        }

    }
}
