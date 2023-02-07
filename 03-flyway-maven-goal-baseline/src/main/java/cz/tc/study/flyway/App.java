package cz.tc.study.flyway;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Database example - hsqldb; drop, create and insert statement
 */
public class App 
{

    private static final String db = "jdbc:hsqldb:file:target/db/flyway_sample;shutdown=true";

    public static void main( String[] args ) throws Exception
    {
        if(args == null || args.length == 0) {
            throw new IllegalArgumentException("input argument cannot be null, use one of: 'init' or 'select'");
        }

        App app = new App();
        // @see https://www.hsqldb.org/doc/1.8/guide/ch09.html#drop_table-section
        String drop = "DROP TABLE PERSON IF EXISTS";
        String create = app.getFileContent("db/migration/V1__Create_person_table.sql");
        String insert = app.getFileContent("db/migration/V2__Add_people.sql");

        try (Connection connection = DriverManager.getConnection(db, "sa", null);) {
            switch(args[0]) {
                case "init":
                    app.executeSql(connection, drop, "DROP TABLE PERSON executed");
                    app.executeSql(connection, create, "CREATE TABLE PERSON executed");
                    app.executeSql(connection, insert, "INSERT data into TABLE PERSON executed");
                    break;
                case "select":
                    try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM PERSON");) {
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
                    break;
                default:
                    throw new IllegalArgumentException("uknown input argument, use one of: 'init' or 'select'");
            }
        }
    }

    private void executeSql(Connection connection, String sql, String message){
        try (Statement statement = connection.createStatement();) {
            statement.execute(sql);
            System.out.println(message);//"DROP TABLE PERSON executed", 
        } catch (SQLException e) {
            printSQLException(e);
        }        
    }

    // @see https://www.javaguides.net/2019/08/java-hsql-tutorial-create-read-update-delete-jdbc-examples.html
    private static void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
    
    private String getFileContent(String fileName) {
        StringBuilder sb = new StringBuilder();
        try (InputStream inputStream = getFileFromResourceAsStream(fileName);
             InputStreamReader streamReader = new InputStreamReader(inputStream, StandardCharsets.UTF_8);
             BufferedReader reader = new BufferedReader(streamReader)) {

            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append("\n");
            }
            return sb.toString();
        } catch (IOException e) {
            throw new IllegalStateException(e);
        }        
    }

    private InputStream getFileFromResourceAsStream(String fileName) {
        ClassLoader classLoader = getClass().getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream(fileName);

        // the stream holding the file content
        if (inputStream == null) {
            throw new IllegalArgumentException("file not found! " + fileName);
        } else {
            return inputStream;
        }

    }    
}
