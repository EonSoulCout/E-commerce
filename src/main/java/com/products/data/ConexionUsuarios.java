package com.products.data;

import java.sql.*;

public class ConexionUsuarios {
    private String driver;
    private String user;
    private String pwd;
    private String cadena;
    private Connection con;

    public ConexionUsuarios() {
        this.driver = "org.postgresql.Driver";
        this.user = "postgres";
        this.pwd = "admin";
        this.cadena = "jdbc:postgresql://localhost:5432/db_nexared";
        this.con = this.crearConexion();
    }

    public Connection getConexion() {
        return this.con;
    }

    private Connection crearConexion() {
        try {
            Class.forName(driver);
            this.con = DriverManager.getConnection(cadena, user, pwd);
            return this.con;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public String Ejecutar(String sql) {
        String error = "";
        try (Statement stmt = getConexion().createStatement()) {
            stmt.execute(sql);
            error = "Datos insertados correctamente";
        } catch (SQLException ex) {
            error = ex.getMessage();
        }
        return error;
    }

    public ResultSet Consulta(String sql) {
        ResultSet reg = null;
        try (Statement stmt = getConexion().createStatement()) {
            reg = stmt.executeQuery(sql);
        } catch (SQLException ee) {
            ee.printStackTrace();
        }
        return reg;
    }
}
