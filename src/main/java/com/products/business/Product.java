package com.products.business;

import com.products.data.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class Product {
    private int id;
    private String nombre;
    private double precio;
    private int stock;
    private String imagen; // Almacenará el nombre del archivo de imagen, ej: "router_modelo_xyz.jpg"

    // Constructor sin argumentos
    public Product() {}

    // Constructor para crear objetos Product con datos
    public Product(int id, String nombre, double precio, int stock, String imagen) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;
        this.imagen = imagen;
    }

    // Getters
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public double getPrecio() { return precio; }
    public int getStock() { return stock; }
    public String getImagen() { return imagen; }

    /**
     * Obtiene los IDs de todas las categorías únicas que tienen al menos un producto asociado
     * en la tabla de productos.
     * @return Una lista de IDs de categorías (Integer). Retorna lista vacía en caso de error o si no hay coincidencias.
     */
    public List<Integer> obtenerTodosLosIdsDeCategoriasUnicasConProductos() {
        List<Integer> idsCategorias = new ArrayList<>();
        // Asegúrate que 'tb_products' y 'id_cate' sean los nombres correctos de tu tabla y columna.
        String sql = "SELECT DISTINCT id_cate FROM tb_products ORDER BY id_cate";
        Conexion gestorConexion = new Conexion();

        try (Connection conn = gestorConexion.getConexion();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                idsCategorias.add(rs.getInt("id_cate"));
            }
        } catch (SQLException e) {
            System.err.println("Error SQL al obtener IDs de categorías únicas con productos: " + e.getMessage());
            e.printStackTrace();
        } catch (NullPointerException e) {
            System.err.println("Error: La conexión a la base de datos no se pudo establecer (es nula). Verifica la clase Conexion.");
            e.printStackTrace();
        }
        return idsCategorias;
    }
    
    /**
     * Método privado para obtener una lista de objetos Product para una categoría específica.
     * @param idCategoria El ID de la categoría de la cual se quieren obtener los productos.
     * @return Una lista de objetos Product. Retorna lista vacía si no hay productos o en caso de error.
     */
    public List<Product> fetchProductosPorCategoria(int idCategoria) {
        List<Product> productos = new ArrayList<>();
        // Asegúrate que los nombres de columnas coincidan con tu BD
        String sql = "SELECT id_pr, name_pr, stock_pr, pric_pr, image_pr FROM tb_products WHERE id_cate = ? ORDER BY id_cate";
        
        Conexion gestorConexion = new Conexion();
        try (Connection conn = gestorConexion.getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setInt(1, idCategoria);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    productos.add(new Product(
                        rs.getInt("id_pr"),
                        rs.getString("name_pr"),
                        rs.getDouble("pric_pr"),
                        rs.getInt("stock_pr"),
                        rs.getString("image_pr")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error SQL al obtener productos: " + e.getMessage());
            e.printStackTrace();
        }
        return productos;
    }

    /**
     * Genera el código HTML para mostrar los productos de una categoría específica.
     * Este método es llamado desde los JSPs.
     * Utiliza las clases CSS definidas en 'des_products.css'.
     * @param idCategoria El ID de la categoría para la cual generar el HTML de productos.
     * @return Un String que contiene el HTML de las tarjetas de producto para la categoría dada.
     * Retorna String vacío si no hay productos o si ocurre un error.
     */
    public String generarHtmlParaProductosDeCategoria(int idCategoria) {
        StringBuilder html = new StringBuilder();
        List<Product> productosDeCategoria = this.fetchProductosPorCategoria(idCategoria);

        if (!productosDeCategoria.isEmpty()) {
            for (Product prod : productosDeCategoria) {
                html.append("<div class='product-card'>\n")
                    .append("    <div class='product-image'>\n")
                    .append("        <img src='images/").append(asignarImagenProducto(prod))
                    .append("' alt='").append(escapeHtml(prod.getNombre())).append("'>\n")
                    .append("    </div>\n")
                    .append("    <h3>").append(escapeHtml(prod.getNombre())).append("</h3>\n")
                    .append("    <p class='price'>$")
                    .append(String.format(Locale.US, "%.2f", prod.getPrecio()))
                    .append("</p>\n")
                    .append("    <p class='stock'>Stock: ").append(prod.getStock()).append("</p>\n")
                    .append("</div>\n");
            }
        }
        return html.toString();
    }

    /**
     * Método auxiliar para escapar caracteres HTML especiales.
     * @param text El texto a escapar.
     * @return El texto con caracteres HTML escapados.
     */
    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
    
    /**
     * Método para determinar la imagen adecuada para cada producto
     * @param producto El producto al que se le asignará la imagen
     * @return Nombre del archivo de imagen correspondiente
     */
    public String asignarImagenProducto(Product producto) {
        String nombreProducto = producto.getNombre().toLowerCase();
        
        // Primero verificamos si hay una imagen específica en la base de datos
        if (producto.getImagen() != null && !producto.getImagen().trim().isEmpty()) {
            return producto.getImagen().trim();
        }
        
        // Asignación de imágenes basada en palabras clave del nombre del producto
        if (nombreProducto.contains("router")) {
            return "router_conenct.jpg";
        } else if (nombreProducto.contains("cable") || nombreProducto.contains("ethernet")) {
            return "cat_5.jpg";
        } else if (nombreProducto.contains("switch")) {
            return nombreProducto.contains("cisco") ? "switnch.jpg" : "switch_conec.jpg";
        } else if (nombreProducto.contains("ponchadora") || nombreProducto.contains("cortacables")) {
            return "wire_cut.jpg";
        } else if (nombreProducto.contains("tester")) {
            return "tester_net.jpg";
        } else if (nombreProducto.contains("arduino")) {
            return "arduinoM.jpg";
        } else if (nombreProducto.contains("hub")) {
            return "hub.jpg";
        } else if (nombreProducto.contains("rack")) {
            return "rack.jpg";
        }
        
        // Imagen por defecto si no coincide con ningún patrón
        return "icono.png";
    }
    
    public static boolean insertarProducto(int idPr, int idCate, String nombre, int stock, double precio, String imagen) {
        String sql = "INSERT INTO tb_products (id_pr, id_cate, name_pr, stock_pr, pric_pr, image_pr) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new Conexion().getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setInt(1, idPr);          
            pst.setInt(2, idCate);        
            pst.setString(3, nombre);     
            pst.setInt(4, stock);         
            pst.setDouble(5, precio);      
            
            if (imagen == null || imagen.trim().isEmpty()) {
                pst.setNull(6, Types.VARCHAR);
            } else {
                pst.setString(6, imagen);
            }
            
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al insertar: " + e.getMessage());
            return false;
        }
    }
}
