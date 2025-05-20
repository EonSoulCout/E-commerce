<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.products.login.Usuario" %>
<%@ page import="com.products.login.UsuarioDAO" %>

<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");
    
    // Validación de campos
    if (correo == null || correo.trim().isEmpty() || contrasena == null || contrasena.isEmpty()) {
        System.out.println("Campos vacíos detectados");
        response.sendRedirect("user_login.jsp?error=campos_vacios");
        return;
    }

    UsuarioDAO usuarioDAO = new UsuarioDAO();
    Usuario usuario = null;
    boolean error = false;

    try {
        usuario = usuarioDAO.obtenerUsuarioPorCorreo(correo.trim());
        
        if (usuario != null) {
            System.out.println("Usuario obtenido de DB: " + usuario.getCorreo());
            if (usuarioDAO.verificarContrasena(usuario, contrasena)) {
                session.setAttribute("usuario", usuario);
                System.out.println("Login exitoso para: " + usuario.getCorreo());
                response.sendRedirect("user_perfil.jsp");
                return;
            }
        }
        error = true;
    } catch (Exception e) {
        System.out.println("Error durante login:");
        e.printStackTrace();
        error = true;
    }

    if (error) {
        System.out.println("Redirigiendo a login con error");
        response.sendRedirect("user_login.jsp?error=credenciales_incorrectas");
    }
%>