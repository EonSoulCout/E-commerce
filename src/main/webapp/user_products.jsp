<%@ page import="com.products.business.Product" %>
<%@ page import="com.products.business.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos de Red | Nexared</title>
    <link href="css/des_products.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header class="main-header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-network-wired"></i>	
                <span>Nexared</span>
            </div>
            <nav class="main-nav">
                <a href="index.jsp"><i class="fas fa-home"></i> Inicio</a>
                <a href="user_category.jsp"><i class="fas fa-filter"></i> Filtrar </a>
                <a href="charge.jsp"><i class="fas fa-server"></i> Servicios</a>
                <a href="user_login.jsp" class="login-btn"><i class="fas fa-sign-in-alt"></i> Acceso</a>
            </nav>
        </div>
    </header>

    <main class="products-layout">
        <div class="products-container">
            <h2 class="section-title">
                <i class="fas fa-box-open"></i> Nuestro Catálogo de Productos
            </h2>
            
            <div class="products-content">
                <%
                    Product pr = new Product();
                    List<Integer> idsCategorias = pr.obtenerTodosLosIdsDeCategoriasUnicasConProductos();
                    
                    if (idsCategorias.isEmpty()) {
                        out.print("<div class='empty-state'>");
                        out.print("<i class='fas fa-box-open'></i>");
                        out.print("<p>Actualmente no hay productos disponibles</p>");
                        out.print("</div>");
                    } else {
                        for (int idCategoria : idsCategorias) {
                            String nombreCategoria = Categoria.obtenerNombreCategoriaPorId(idCategoria);
                            out.print("<div class='category-section'>");
                            out.print("<h3 class='category-title'>");
                            out.print("<i class='fas fa-folder-open'></i> " + nombreCategoria);
                            out.print("</h3>");
                            out.print("<div class='products-grid'>");
                            
                            List<Product> productos = pr.fetchProductosPorCategoria(idCategoria);
                            if (productos.isEmpty()) {
                                out.print("<div class='empty-state'>");
                                out.print("<p>No hay productos en esta categoría</p>");
                                out.print("</div>");
                            } else {
                                for (Product producto : productos) {
                                    String imagenProducto = pr.asignarImagenProducto(producto);
                                    out.print("<div class='product-card'>");
                                    out.print("<div class='product-badge'>");
                                    out.print("<span class='stock-badge " + (producto.getStock() > 0 ? "in-stock" : "out-stock") + "'>");
                                    out.print(producto.getStock() > 0 ? "Disponible" : "Agotado");
                                    out.print("</span>");
                                    out.print("</div>");
                                    out.print("<div class='product-image'>");
                                    out.print("<img src='images/" + imagenProducto + "' alt='" + producto.getNombre() + "' loading='lazy'>");
                                    out.print("</div>");
                                    out.print("<div class='product-info'>");
                                    out.print("<h4 class='product-name'>" + producto.getNombre() + "</h4>");
                                    out.print("<div class='product-meta'>");
                                    out.print("<span class='product-price'>$" + String.format("%.2f", producto.getPrecio()) + "</span>");
                                    out.print("<span class='product-stock'><i class='fas fa-cubes'></i> " + producto.getStock() + " unidades</span>");
                                    out.print("</div>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                            }
                            out.print("</div></div>");
                        }
                    }
                %>
            </div>
        </div>
    </main>

    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-brand">
                <i class="fas fa-network-wired"></i>
                <span>Nexared</span>
            </div>
            <p class="copyright">© 2025 Soluciones de Red Profesional</p>
        </div>
    </footer>
</body>
</html>