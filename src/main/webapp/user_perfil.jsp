<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat, java.util.Date, javax.servlet.http.HttpSession, java.io.*" %>
<%@ page import="com.products.login.Usuario" %> <%-- Asegúrate que esta clase Usuario exista en tu proyecto --%>
<%@ page import="com.products.login.Pagina" %> <%-- IMPORTANTE: Añadir la importación de la clase Pagina --%>

<%
    // 1. Obtener el objeto Usuario de la sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    // 2. Si el usuario no está en sesión, redirigir al login
    if (usuario == null) {
        response.sendRedirect("user_login.jsp"); // Cambia "login.jsp" si tu página de login tiene otro nombre
        return;
    }

    // 3. Procesar información del usuario
    String fotoBase64 = "";
    if (usuario.getFoto() != null && usuario.getFoto().length > 0) {
        fotoBase64 = Base64.getEncoder().encodeToString(usuario.getFoto());
    }

    String nombrePerfil = "Desconocido";
    int perfilId = usuario.getPerfilId(); // Asumiendo que getPerfilId() devuelve un int
    switch (perfilId) {
        case 1:
            nombrePerfil = "Administrador";
            break;
        case 2:
            nombrePerfil = "Cliente";
            break;
        case 3:
            nombrePerfil = "Empleado";
            break;
        default:
            nombrePerfil = "No definido";
            break;
    }
    
    String fechaNacimientoFormateada = "No disponible";
    if (usuario.getFechaNacimiento() != null) {
        // Formato "Mes Año" (ej: "Mayo 2025")
        SimpleDateFormat sdfOut = new SimpleDateFormat("MMMM yyyy", new Locale("es", "ES")); 
        fechaNacimientoFormateada = sdfOut.format(usuario.getFechaNacimiento());
    }
    
    String colorFavoritoHex = (usuario.getColorFavorito() != null && !usuario.getColorFavorito().isEmpty()) ? usuario.getColorFavorito() : "#ffffff";

    // 4. Obtener información de la sesión
    HttpSession sesion = request.getSession(false); // false para no crear una nueva si no existe (aunque ya debería existir)
    String sessionId = "";
    String creationTime = "";
    String isNewSession = "";

    if (sesion != null) {
        sessionId = sesion.getId();
        creationTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(sesion.getCreationTime()));
        isNewSession = String.valueOf(sesion.isNew());
    }

%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Nexared</title>
    <link rel="stylesheet" href="css/des_perfil.css"> <%-- Enlace a tu archivo CSS --%>
</head>
<body>

    <header>
        <h1>Bienvenido a Nexared</h1>
    </header>

    <div class="main-container">
        <div class="perfil-container">
            <div class="foto-container">
                <% if (!fotoBase64.isEmpty()) { %>
                    <img src="data:image/jpeg;base64,<%= fotoBase64 %>" alt="Foto de perfil" class="foto-perfil" />
                <% } else { %>
                    <img src="images/default_avatar.png" alt="Foto de perfil no disponible" class="foto-perfil" /> 
                    <%-- Asegúrate que 'images/default_avatar.png' exista en la ruta correcta --%>
                <% } %>
            </div>

            <div class="datos-usuario">
                <h2>¡Hola, <%= usuario.getNombre() != null ? usuario.getNombre() : "Usuario" %>!</h2>
                
                <div class="info-section">
                    <h3>Detalles del Perfil</h3>
                    <div class="campo"><label>Nombre Completo:</label> <span><%= usuario.getNombre() != null ? usuario.getNombre() : "No especificado" %></span></div>
                    <div class="campo"><label>Correo Electrónico:</label> <span><%= usuario.getCorreo() != null ? usuario.getCorreo() : "No especificado" %></span></div>
                    <div class="campo"><label>Cédula:</label> <span><%= usuario.getCedula() != null ? usuario.getCedula() : "No especificada" %></span></div>
                    <div class="campo"><label>Tipo de Perfil:</label> <span><%= nombrePerfil %></span></div>
                    <div class="campo"><label>Estado Civil:</label> <span><%= usuario.getEstadoCivil() != null ? usuario.getEstadoCivil() : "No especificado" %></span></div>
                    <div class="campo"><label>Lugar de Residencia:</label> <span><%= usuario.getResidencia() != null ? usuario.getResidencia() : "No especificada" %></span></div>
                    <div class="campo"><label>Fecha de Nacimiento:</label> <span><%= fechaNacimientoFormateada %></span></div>
                    <div class="campo">
                        <label>Color Favorito:</label> 
                        <div>
                           <span class="color-preview-box" style="background-color: <%= colorFavoritoHex %>;"></span>
                           <%= (usuario.getColorFavorito() != null && !usuario.getColorFavorito().isEmpty()) ? usuario.getColorFavorito() : "No especificado" %>
                        </div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>Información de la Sesión</h3>
                    <div class="campo"><label>ID de sesión:</label> <span><%= sessionId %></span></div>
                    <div class="campo"><label>Hora de creación:</label> <span><%= creationTime %></span></div>
                    <div class="campo"><label>¿Sesión nueva?:</label> <span><%= isNewSession %></span></div>
                </div>

                <%-- Sección de Acciones Especiales según el Perfil (AHORA DINÁMICA) --%>
                <div class="acciones-especiales info-section">
                    <h3>Acciones Disponibles</h3>
                    <%
                        // Texto introductorio según el perfil
                        String introText = "";
                        switch (perfilId) {
                            case 1: // Administrador
                                introText = "<p>Como <strong>Administrador</strong>, tienes acceso a las siguientes herramientas de gestión:</p>";
                                break;
                            case 2: // Cliente
                                introText = "<p>Como <strong>Cliente</strong>, puedes gestionar tus compras, preferencias y más acciones:</p>";
                                break;
                            case 3: // Empleado
                                introText = "<p>Como <strong>Empleado</strong>, aquí tienes acceso a tus herramientas de trabajo y recursos:</p>";
                                break;
                        }
                        if (!introText.isEmpty()) {
                            out.println(introText); // Imprimir el texto introductorio si existe
                        }

                        // Instanciar Pagina y obtener el menú dinámico
                        Pagina paginaDinamica = new Pagina();
                        String menuHtmlDinamico = paginaDinamica.mostrarMenu(perfilId);
                        
                        // Imprimir el menú dinámico
                        // La clase Pagina.mostrarMenu ya incluye un mensaje si no hay acciones 
                        // o si ocurre un error. Los botones tendrán la clase "btn btn-menu-action".
                        out.println("<div class='botones-acciones'>"); // Contenedor para los botones
                        out.println(menuHtmlDinamico);
                        out.println("</div>");
                    %>
                </div>
                
                <div class="logout-section">
                    <a href="user_logout.jsp" class="btn btn-logout">Cerrar Sesión</a> 
                    <%-- Cambia "logout.jsp" si tu script de logout tiene otro nombre --%>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; <%= new SimpleDateFormat("yyyy").format(new Date()) %> Nexared. Todos los derechos reservados.</p>
    </footer>

</body>
</html>