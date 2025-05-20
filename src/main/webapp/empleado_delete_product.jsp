<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.products.data.Conexion" %>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    int id = Integer.parseInt(request.getParameter("id"));
    
    try {
        String sql = "DELETE FROM tb_products WHERE id_pr = ?";
        try (Connection conn = new Conexion().getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                response.sendRedirect("empleado_gestion.jsp?mensaje=Producto eliminado correctamente&tipo=success");
            } else {
                response.sendRedirect("empleado_gestion.jsp?mensaje=No se encontró el producto a eliminar&tipo=error");
            }
        }
    } catch (Exception e) {
        response.sendRedirect("empleado_gestion.jsp?mensaje=Error al eliminar el producto: " + e.getMessage() + "&tipo=error");
    }
} else {
    response.sendRedirect("empleado_gestion.jsp");
}
%>