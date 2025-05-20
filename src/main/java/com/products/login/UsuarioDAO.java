package com.products.login;

import java.sql.*;
import com.products.data.ConexionUsuarios;

public class UsuarioDAO {
    private static final String TABLA_USUARIO = "tb_usuario";

    // Método para insertar un usuario en la base de datos
    public boolean registrarUsuario(Usuario usuario, int perfilId) throws SQLException {
        String sql = "INSERT INTO " + TABLA_USUARIO + " (nombre_us, cedula_us, correo_us, contrasena_us, "
                   + "estado_civil_us, residencia_us, color_favorito_us, fecha_nacimiento_us, foto_us, id_per) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = new ConexionUsuarios().getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            setUsuarioParameters(stmt, usuario, perfilId);
            return stmt.executeUpdate() > 0;
        }
    }

    public Usuario obtenerUsuarioPorCorreo(String correo) throws SQLException {
        String sql = "SELECT * FROM tb_usuario WHERE correo_us = ?";
        System.out.println("Buscando usuario con correo: " + correo); // Debug
        
        try (Connection con = new ConexionUsuarios().getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setString(1, correo);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Usuario usuario = mapResultSetToUsuario(rs);
                System.out.println("Usuario encontrado: " + usuario.getCorreo()); // Debug
                System.out.println("Contraseña almacenada: " + usuario.getContrasena()); // Debug
                return usuario;
            } else {
                System.out.println("No se encontró usuario con ese correo"); // Debug
                return null;
            }
        }
    }

    public boolean verificarContrasena(Usuario usuario, String contrasenaIngresada) {
        if (usuario == null) {
            System.out.println("Usuario es null en verificarContrasena"); // Debug
            return false;
        }
        
        System.out.println("Comparando contraseñas:"); // Debug
        System.out.println("Almacenada: '" + usuario.getContrasena() + "'"); // Debug
        System.out.println("Ingresada: '" + contrasenaIngresada + "'"); // Debug
        
        boolean coincide = usuario.getContrasena().equals(contrasenaIngresada);
        System.out.println("Resultado comparación: " + coincide); // Debug
        
        return coincide;
    }

    // Método para obtener el perfil ID de un usuario por correo
    public int obtenerPerfilId(String correo) throws SQLException {
        String sql = "SELECT id_per FROM " + TABLA_USUARIO + " WHERE correo_us = ?";

        try (Connection con = new ConexionUsuarios().getConexion();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setString(1, correo);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getInt("id_per") : 0;
            }
        }
    }

    // Métodos auxiliares privados
    private void setUsuarioParameters(PreparedStatement stmt, Usuario usuario, int perfilId) throws SQLException {
        stmt.setString(1, usuario.getNombre());
        stmt.setString(2, usuario.getCedula());
        stmt.setString(3, usuario.getCorreo());
        stmt.setString(4, usuario.getContrasena());
        stmt.setString(5, usuario.getEstadoCivil());
        stmt.setString(6, usuario.getResidencia());
        stmt.setString(7, usuario.getColorFavorito());
        stmt.setDate(8, new java.sql.Date(usuario.getFechaNacimiento().getTime()));
        stmt.setBytes(9, usuario.getFoto());
        stmt.setInt(10, perfilId);
    }

    private Usuario mapResultSetToUsuario(ResultSet rs) throws SQLException {
        return new Usuario(
            rs.getString("nombre_us"),
            rs.getString("cedula_us"),
            rs.getString("correo_us"),
            rs.getString("contrasena_us"),
            rs.getString("estado_civil_us"),
            rs.getString("residencia_us"),
            rs.getString("color_favorito_us"),
            rs.getDate("fecha_nacimiento_us"),
            rs.getBytes("foto_us"),
            rs.getInt("id_per")
        );
    }
}