package com.products.data;

import java.sql.*;

public class Conexion {
    private String driver;
    private String user;
    private String pwd;
    private String cadena;

    public Conexion() {
        this.driver = "org.postgresql.Driver";
        this.user = "postgres";
        this.pwd = "admin";
        this.cadena = "jdbc:postgresql://localhost:5432/db_nexared";
    }

    // Método para obtener una nueva conexión
    public Connection getConexion() {
        try {
            Class.forName(driver);
            return DriverManager.getConnection(cadena, user, pwd);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error al obtener conexión: " + e.getMessage());
            return null;
        }
    }

    // Método para ejecutar sentencias UPDATE, INSERT o DELETE
    public String Ejecutar(String sql) {
        try (Connection conn = getConexion();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            return "Operación realizada correctamente";
        } catch (SQLException ex) {
            return "Error al ejecutar: " + ex.getMessage();
        }
    }

    // Método para ejecutar consultas SELECT
    public ResultSet Consulta(String sql) {
        try {
            Connection conn = getConexion();
            Statement stmt = conn.createStatement();
            return stmt.executeQuery(sql);
            // Nota: El cierre de estos recursos debe manejarse en el código que llama a este método
        } catch (SQLException ee) {
            System.err.println("Error en consulta: " + ee.getMessage());
            return null;
        }
    }
}