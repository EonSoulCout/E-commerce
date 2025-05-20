<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.products.business.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="css/des_management.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container-fluid py-4">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h2 class="mb-0"><i class="bi bi-box-seam"></i> Gestión de Productos</h2>
                <a href="empleado_update_product.jsp" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Nuevo Producto
                </a>
            </div>
            
            <div class="card-body">
                <%-- Mensajes --%>
                <% if (request.getParameter("mensaje") != null) { %>
                <div class="alert alert-<%= request.getParameter("tipo") %> alert-dismissible fade show">
                    <%= request.getParameter("mensaje") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% } %>
                
                <%-- Tabla de productos --%>
                <%
                Product productManager = new Product();
                List<Integer> categorias = productManager.obtenerTodosLosIdsDeCategoriasUnicasConProductos();
                List<Product> todosProductos = new ArrayList<>();
                
                for (Integer idCategoria : categorias) {
                    todosProductos.addAll(productManager.fetchProductosPorCategoria(idCategoria));
                }
                %>
                
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Imagen</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product p : todosProductos) { %>
                            <tr>
                                <td><%= p.getId() %></td>
                                <td><%= p.getNombre() %></td>
                                <td>$<%= String.format("%,.2f", p.getPrecio()) %></td>
                                <td>
                                    <span class="badge <%= p.getStock() > 10 ? "bg-success" : "bg-warning text-dark" %>">
                                        <%= p.getStock() %>
                                    </span>
                                </td>
                                <td>
                                    <img src="images/<%= p.getImagen() != null ? p.getImagen() : "default.png" %>" 
                                         class="img-thumbnail" style="width: 80px; height: 80px; object-fit: contain;">
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <a href="empleado_update_product.jsp?id=<%= p.getId() %>" 
                                           class="btn btn-sm btn-outline-primary">
                                           <i class="bi bi-pencil"></i> Editar
                                        </a>
                                        <form action="empleado_delete_product.jsp" method="post" class="d-inline">
                                            <input type="hidden" name="id" value="<%= p.getId() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                    onclick="return confirm('¿Eliminar este producto permanentemente?')">
                                                <i class="bi bi-trash"></i> Eliminar
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>