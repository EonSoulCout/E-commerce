<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.products.business.Product" %>
<%@ page import="java.io.File" %>
<%@ page import="com.products.data.Conexion" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%!
// Obtener siguiente ID
private int obtenerSiguienteId() {
    try (Connection conn = new Conexion().getConexion();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT MAX(id_pr) FROM tb_products")) {
        return rs.next() ? rs.getInt(1) + 1 : 1;
    } catch (Exception e) {
        e.printStackTrace();
        return 1;
    }
}

private int obtenerCategoriaProducto(int idProducto) {
    try (Connection conn = new Conexion().getConexion();
         PreparedStatement pst = conn.prepareStatement("SELECT id_cate FROM tb_products WHERE id_pr = ?")) {
        pst.setInt(1, idProducto);
        ResultSet rs = pst.executeQuery();
        return rs.next() ? rs.getInt("id_cate") : 1001;
    } catch (Exception e) {
        e.printStackTrace();
        return 1001;
    }
}
%>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    try {
        String idParam = request.getParameter("id_pr");
        String cateParam = request.getParameter("id_cate");
        String name_pr = request.getParameter("name_pr");
        String stockParam = request.getParameter("stock_pr");
        String priceParam = request.getParameter("pric_pr");
        String image_pr_name = request.getParameter("image_pr");
        boolean esNuevo = "true".equals(request.getParameter("esNuevo"));

        // Validar campos obligatorios
        if (idParam == null || idParam.trim().isEmpty() ||
            cateParam == null || cateParam.trim().isEmpty() ||
            name_pr == null || name_pr.trim().isEmpty() ||
            stockParam == null || stockParam.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty()) {
            throw new Exception("Todos los campos obligatorios deben estar completos");
        }

        int id_pr = Integer.parseInt(idParam);
        int id_cate = Integer.parseInt(cateParam);
        int stock_pr = Integer.parseInt(stockParam);
        double pric_pr = Double.parseDouble(priceParam);
        String nombreImagen = (image_pr_name != null && !image_pr_name.trim().isEmpty()) ? image_pr_name.trim() : null;

        String sql;
        if (esNuevo) {
            sql = "INSERT INTO tb_products (id_pr, id_cate, name_pr, stock_pr, pric_pr, image_pr) VALUES (?, ?, ?, ?, ?, ?)";
        } else {
            sql = "UPDATE tb_products SET id_cate=?, name_pr=?, stock_pr=?, pric_pr=?, image_pr=? WHERE id_pr=?";
        }

        try (Connection conn = new Conexion().getConexion();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            if (esNuevo) {
                pst.setInt(1, id_pr);
                pst.setInt(2, id_cate);
                pst.setString(3, name_pr.trim());
                pst.setInt(4, stock_pr);
                pst.setDouble(5, pric_pr);
                pst.setString(6, nombreImagen);
            } else {
                pst.setInt(1, id_cate);
                pst.setString(2, name_pr.trim());
                pst.setInt(3, stock_pr);
                pst.setDouble(4, pric_pr);
                pst.setString(5, nombreImagen);
                pst.setInt(6, id_pr);
            }

            int affectedRows = pst.executeUpdate();
            String mensaje = affectedRows > 0 ?
                "Producto " + (esNuevo ? "creado" : "actualizado") + " correctamente" :
                "No se realizaron cambios";

            response.sendRedirect("empleado_gestion.jsp?mensaje=" + mensaje + "&tipo=success");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("empleado_gestion.jsp?mensaje=Error: " + e.getMessage() + "&tipo=danger");
    }
    return;
}

Product producto = null;
boolean esNuevo = true;
int id_cate = 1001;

if (request.getParameter("id") != null) {
    try {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        Product productManager = new Product();
        List<Integer> categorias = productManager.obtenerTodosLosIdsDeCategoriasUnicasConProductos();

        for (Integer categoriaId : categorias) {
            for (Product p : productManager.fetchProductosPorCategoria(categoriaId)) {
                if (p.getId() == idProducto) {
                    producto = p;
                    id_cate = obtenerCategoriaProducto(idProducto);
                    esNuevo = false;
                    break;
                }
            }
            if (producto != null) break;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("empleado_gestion.jsp?mensaje=ID+de+producto+inválido&tipo=danger");
        return;
    }
}

String[] imagenes = new File(application.getRealPath("/images")).list();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= esNuevo ? "Nuevo Producto" : "Editar Producto" %></title>
    <link rel="stylesheet" href="css/des_management.css">
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <h2><%= esNuevo ? "Nuevo Producto" : "Editar Producto" %></h2>
        </div>
        <div class="card-body">
            <form method="post">
                <input type="hidden" name="esNuevo" value="<%= esNuevo %>">
                <% if (!esNuevo) { %>
                <input type="hidden" name="id_pr" value="<%= producto.getId() %>">
                <% } %>

                <% if (esNuevo) { %>
                <div class="form-group">
                    <label for="id_pr">ID Producto</label>
                    <input type="number" name="id_pr" id="id_pr" value="<%= obtenerSiguienteId() %>" readonly required>
                </div>
                <% } %>

                <div class="form-group">
                    <label for="id_cate">Categoría</label>
                    <select name="id_cate" id="id_cate" required>
                        <option value="1001" <%= id_cate == 1001 ? "selected" : "" %>>Redes</option>
                        <option value="1002" <%= id_cate == 1002 ? "selected" : "" %>>Cables</option>
                        <option value="1003" <%= id_cate == 1003 ? "selected" : "" %>>Switches</option>
                        <option value="1004" <%= id_cate == 1004 ? "selected" : "" %>>Herramientas</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="name_pr">Nombre</label>
                    <input type="text" name="name_pr" id="name_pr" value="<%= !esNuevo ? producto.getNombre() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="stock_pr">Stock</label>
                    <input type="number" name="stock_pr" id="stock_pr" value="<%= !esNuevo ? producto.getStock() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="pric_pr">Precio</label>
                    <input type="number" step="0.01" name="pric_pr" id="pric_pr" value="<%= !esNuevo ? producto.getPrecio() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="image_pr">Imagen</label>
                    <select name="image_pr" id="image_pr">
                        <option value="">-- Seleccione una imagen --</option>
                        <% if (imagenes != null) {
                            for (String img : imagenes) {
                                if (img.toLowerCase().matches(".*\\.(jpg|jpeg|png|gif)$")) {
                                    boolean selected = !esNuevo && producto.getImagen() != null && producto.getImagen().equalsIgnoreCase(img);
                        %>
                        <option value="<%= img %>" <%= selected ? "selected" : "" %>><%= img %></option>
                        <% }}} %>
                    </select>

                    <% if (!esNuevo && producto.getImagen() != null) { %>
                    <div class="current-image">
                        <img src="images/<%= producto.getImagen() %>" alt="Imagen actual" class="img-preview">
                    </div>
                    <% } %>
                </div>

                <div class="form-actions">
                    <a href="empleado_gestion.jsp" class="btn btn-cancel">Cancelar</a>
                    <button type="submit" class="btn btn-submit"><%= esNuevo ? "Crear Producto" : "Guardar Cambios" %></button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
