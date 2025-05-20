package com.products.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
// Importa tu clase Conexion específica. Asegúrate que esté en el paquete correcto.
import com.products.data.Conexion;

public class Pagina {

    // ... (método getButtonDetails se mantiene igual) ...

    public String mostrarMenu(Integer nperfil) {
        StringBuilder menuHtml = new StringBuilder();
        String sql = "SELECT pag.id_pag, pag.descrip_pag, pag.path_pag " +
                     "FROM tb_pagina pag " +
                     "JOIN tb_redirect pper ON pag.id_pag = pper.id_pag " +
                     "WHERE pper.id_per = ?";
        

        Conexion con = new Conexion(); 
        Connection cn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            cn = con.getConexion(); 
            
            if (cn == null) {
                System.out.println("Error: No se pudo establecer la conexión a la base de datos.");
                return "<p class='error'>Error al cargar el menú (DB Connection).</p>";
            }
            
            pst = cn.prepareStatement(sql);
            pst.setInt(1, nperfil);
            
            rs = pst.executeQuery();

            if (!rs.isBeforeFirst()) {
                menuHtml.append("<p>No hay acciones disponibles para tu perfil.</p>");
            } else {
                while (rs.next()) {
                    int idPag = rs.getInt("id_pag");
                    String descriptPage = rs.getString("descrip_pag");
                    String pathPage = rs.getString("path_pag");

                    String[] details = getButtonDetails(idPag, descriptPage);
                    String emoji = details[0];
                    String explicacion = details[1];

                    menuHtml.append("<a href=\"").append(pathPage).append("\" ")
                            .append("class=\"btn btn-menu-action\" ")
                            .append("title=\"").append(explicacion).append("\">")
                            .append("<span class=\"emoji\">").append(emoji).append("</span> ")
                            .append(descriptPage)
                            .append("</a>");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error SQL al generar menú: " + e.getMessage());
            e.printStackTrace();
            menuHtml.append("<p class='error'>Error al cargar el menú: ").append(e.getMessage()).append("</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                // AJUSTE 2: Cerrar la conexión directamente. 
                // Tu clase Conexion no tiene un método desconectar().
                if (cn != null) cn.close(); 
            } catch (SQLException ex) {
                System.err.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        return menuHtml.toString();
    }

    private String[] getButtonDetails(int idPag, String descriptPage) {
        String emoji = "📄"; 
        String explicacion = descriptPage; 

        switch (idPag) {
            case 1: emoji = "🚪"; explicacion = "Finalizar tu sesión actual y salir de forma segura."; break;
            case 2: emoji = "🔑"; explicacion = "Actualizar tu contraseña para mayor seguridad."; break;
            case 3: emoji = "🛒"; explicacion = "Ver y gestionar los productos en tu carrito de compras."; break;
            case 4: emoji = "📊"; explicacion = "Acceder al panel de administración o revisar la bitácora del sistema."; break;
            case 5: emoji = "👥"; explicacion = "Gestionar el registro de nuevos empleados o acceder al panel principal."; break;
            case 6: emoji = "🧰"; explicacion = "Gestionar productos del inventario: agregar, editar o eliminar."; break;
            default: emoji = "🔗"; explicacion = "Acceder a: " + descriptPage; break;
        }
        return new String[]{emoji, explicacion};
    }

}