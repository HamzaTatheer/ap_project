package com.example.ap_project.db;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;

public class SqlHelper {
    public static Connection createConnection(){
        try {
            String url = "jdbc:sqlserver://localhost:5001;databaseName=HealthStreet;user=sa;password=Database2021!";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(url);
            DatabaseMetaData dm = con.getMetaData();
            System.out.println(dm.getDriverVersion());
            System.out.println(dm.getDriverName());
            System.out.println(dm.getDatabaseProductName());
            System.out.println(dm.getDatabaseProductVersion());
            return con;

        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }


}
