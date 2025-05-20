package com.products.business;

import com.products.data.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Categoria {
    private int id;
    private String descripcion;

    // Constructor sin argumentos, útil si se instancia sin datos iniciales
    public Categoria() {}

    // Constructor para crear objetos Categoria con datos
    public Categoria(int id, String descripcion) {
        this.id = id;
        this.descripcion = descripcion;
    }

    // Getters
    public int getId() { 
        return id; 
    }

    public String getDescripcion() { 
        return descripcion; 
    }

    /**
     * Obtiene todas las categorías de la base de datos.
     * Utiliza try-with-resources para un manejo adecuado de la conexión.
     * @return Una lista de objetos Categoria. Retorna lista vacía en caso de error o si no hay categorías.
     */
    public static List<Categoria> obtenerTodas() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT id_cate, desc_cate FROM tb_categories ORDER BY desc_cate";
        
        Conexion gestorConexion = new Conexion();
        try (Connection conn = gestorConexion.getConexion();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                categorias.add(new Categoria(
                    rs.getInt("id_cate"),
                    rs.getString("desc_cate")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error SQL al obtener categorías: " + e.getMessage());
        }
        return categorias;
    }
    
    /**
     * Obtiene el nombre de una categoría específica por su ID.
     * @param idCategoria El ID de la categoría a buscar.
     * @return El nombre de la categoría como String, o null si no se encuentra o hay un error.
     */
    public static String obtenerNombreCategoriaPorId(int idCategoria) {
        String nombreCategoria = null;
        String sql = "SELECT desc_cate FROM tb_categories WHERE id_cate = ?";
        Conexion gestorConexion = new Conexion();

        try (Connection conn = gestorConexion.getConexion();	
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setInt(1, idCategoria); // Establece el parámetro en el PreparedStatement
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    nombreCategoria = rs.getString("desc_cate");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error SQL al obtener nombre de categoría por ID " + idCategoria + ": " + e.getMessage());
            e.printStackTrace();
        } catch (NullPointerException e) {
            System.err.println("Error: La conexión a la base de datos no se pudo establecer al buscar nombre de categoría.");
            e.printStackTrace();
        }
        return nombreCategoria;
    }

    /**
     * Genera el HTML para los radio buttons de categorías, que se usarán en el formulario de filtro.
     * Este método es llamado desde el JSP.
     * @return String con el HTML de los radio buttons.
     */
    public String mostrarCategoriasParaFiltro() {
        List<Categoria> todasLasCategorias = Categoria.obtenerTodas(); // Llama al método estático
        StringBuilder html = new StringBuilder();

        if (todasLasCategorias.isEmpty()) {
            html.append("<p>No hay categorías disponibles para filtrar en este momento.</p>");
        } else {
            // El JSP se encargará del <form>, <div class="filter-group"> y <h4>.
            // Esta función solo genera los <label> con <input type="radio">.
            for (Categoria cat : todasLasCategorias) {
                html.append("<label>\n") // La clase CSS para el label se aplica en el CSS general o en el JSP si es necesario.
                    .append("    <input type='radio' name='categoria' value='").append(cat.getId()).append("'> ")
                    .append(escapeHtml(cat.getDescripcion())) // Escapar caracteres HTML para seguridad
                    .append("\n</label><br/>\n"); // Agrego <br/> para separación visual si no se usa CSS flex/grid en el contenedor
            }
        }
        return html.toString();
    }

    /**
     * Método auxiliar para escapar caracteres HTML especiales en los textos
     * que se mostrarán en la página. Esto previene ataques XSS.
     * @param text El texto a escapar.
     * @return El texto con caracteres HTML escapados.
     */
    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        // Reemplaza los caracteres especiales de HTML con sus entidades correspondientes.
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}
