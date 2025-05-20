<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.products.business.Categoria" %>
<%@ page import="com.products.business.Product" %>
<%@ page import= "java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorías - Nexared</title>
    <link href="css/des_products.css" rel="stylesheet" type="text/css">
</head>
<body>
    <header>
        <h1>Nexared</h1>
        <h2>Infraestructura de Red</h2>
    </header>

    <nav>
        <a href="index.jsp">Inicio</a>
        <a href="user_products.jsp">Ver Productos</a>
        <a href="charge.jsp">Servicios</a>
        <a href="user_login.jsp">Login</a>
    </nav>

    <div class="layout">
        <div class="filters">
            <form method="post">
                <div class="filter-group">
                    <h4>Filtrar por Categoría</h4>
                    <label>
                        <input type="radio" name="categoria" value="0" 
                        <%= (request.getParameter("categoria") == null || "0".equals(request.getParameter("categoria"))) ? "checked" : "" %>> 
                        Todas las categorías
                    </label><br/>
                    <% 
                        Categoria cat = new Categoria();
                        out.print(cat.mostrarCategoriasParaFiltro()); 
                    %>
                </div>
                <button type="submit">Buscar productos</button>
            </form>
        </div>

        <div class="products">
            <%
                String categoriaElegida = request.getParameter("categoria");
                Product pr = new Product();
                int idCategoria = 0; // Valor por defecto para mostrar todos los productos

                if (categoriaElegida != null && !categoriaElegida.isEmpty()) {
                    try {
                        idCategoria = Integer.parseInt(categoriaElegida);
                    } catch (NumberFormatException e) {
                        out.print("<p class='error-message'>Error: Seleccione una categoría válida</p>");
                    }
                }

                // Mostrar productos según la categoría seleccionada (0 = todas)
                out.print("<div class='products-container'>");
                if (idCategoria == 0) {
                    // Mostrar todos los productos de todas las categorías
                    List<Integer> idsCategorias = pr.obtenerTodosLosIdsDeCategoriasUnicasConProductos();
                    if (idsCategorias.isEmpty()) {
                        out.print("<p class='info-message'>No hay productos disponibles en este momento.</p>");
                    } else {
                        for (int catId : idsCategorias) {
                            out.print(pr.generarHtmlParaProductosDeCategoria(catId));
                        }
                    }
                } else {
                    // Mostrar productos de una categoría específica
                    String htmlProductos = pr.generarHtmlParaProductosDeCategoria(idCategoria);
                    if (htmlProductos.isEmpty()) {
                        out.print("<p class='info-message'>No hay productos disponibles en esta categoría.</p>");
                    } else {
                        out.print(htmlProductos);
                    }
                }
                out.print("</div>");
            %>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <ul class="footer-links">
                <li><a href="#">Facebook</a></li>
                <li><a href="#">Instagram</a></li>
                <li><a href="#">Twitter</a></li>
            </ul>
            <p class="copyright">© 2023 Hardware de Red Profesional</p>
        </div>
    </footer>
</body>
</html>