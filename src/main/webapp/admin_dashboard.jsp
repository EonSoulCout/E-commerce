<%@ page import="java.sql.*" %>
<%@ page import="com.products.data.ConexionUsuarios" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link href="css/des_login.css" rel="stylesheet" type="text/css">
<head>
    <title>Registrar Usuario</title>
    <script>
        function togglePasswordField() {
            var role = document.getElementById("rol").value;
            var passwordField = document.getElementById("password");
            if (role === "empleado") {
                passwordField.value = "654321";
                passwordField.readOnly = true;
            } else {
                passwordField.value = "";
                passwordField.readOnly = false;
            }
        }
    </script>
</head>
<body>
    <h2>Registrar Usuario</h2>

    <% 
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Obtener los datos del formulario
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");
            String rol = request.getParameter("rol");

            Connection con = null;
            PreparedStatement ps = null;

            try {
                // Crear la conexión a la base de datos
                ConexionUsuarios conexion = new ConexionUsuarios();
                con = conexion.getConexion();

                // SQL para insertar el nuevo usuario
                String sql = "INSERT INTO usuarios (nombre, correo, usuario, password, rol) VALUES (?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, correo);
                ps.setString(3, usuario);
                ps.setString(4, password);
                ps.setString(5, rol);

                int result = ps.executeUpdate();

                // Verificar si la inserción fue exitosa
                if (result > 0) {
    %>
                    <script>
                        alert("Usuario registrado correctamente.");
                        window.location.href = "admin_dashboard.jsp"; // Redirigir al mismo dashboard
                    </script>
    <%
                } else {
    %>
                    <script>
                        alert("Error al registrar usuario.");
                    </script>
    <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        }
    %>

    <!-- Formulario para registrar usuario -->
    <form action="admin_dashboard.jsp" method="post">
        <label>Nombre:</label>
        <input type="text" name="nombre" required><br>

        <label>Correo:</label>
        <input type="email" name="correo" required><br>

        <label>Usuario:</label>
        <input type="text" name="usuario" required><br>

        <label>Rol:</label>
        <select name="rol" id="rol" onchange="togglePasswordField()" required>
            <option value="">Seleccione un rol</option>
            <option value="empleado">Empleado</option>
            <option value="admin">Administrador</option>
        </select><br>

        <label>Contraseña:</label>
        <input type="password" name="password" id="password" required><br>

        <input type="submit" value="Registrar">
    </form>
</body>
</html>
