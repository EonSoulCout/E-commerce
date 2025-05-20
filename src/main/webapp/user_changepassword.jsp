<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="com.products.login.Usuario" %>
<%@ page import="com.products.login.UsuarioDAO" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Privacidad</title>
    <link href="css/des_login.css" rel="stylesheet" type="text/css">
</head>
<body style="background-image: url('images/switch_conec.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">

    <header>
        <div class="header-content">
            <h1>Cambio de contraseña</h1>
            <p>Aquí puedes gestionar tu perfil y cambiar tu contraseña.</p>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="menu">
            <h2>Menú de Empleado</h2>
            <ul>
                <li><a href="#cambiarClave">Cambiar mi contraseña</a></li>
                <!-- Aquí puedes agregar más enlaces a funciones específicas del empleado -->
            </ul>
        </div>

        <div class="profile-info">
            <h3>Información del Perfil</h3>
            <p>Nombre: ${usuario.nombre}</p>
            <p>Cédula: ${usuario.cedula}</p>
            <p>Correo: ${usuario.correo}</p>
            <!-- Mostrar más detalles del usuario -->
        </div>
        
        <!-- Formulario de Cambio de Contraseña -->
        <div id="cambiarClave" class="cambiar-clave-form">
            <h3>Cambiar Contraseña</h3>
            <form action="change_process.jsp" method="post">
                <label for="txtContraseñaActual">Contraseña Actual</label>
                <input type="password" id="txtContraseñaActual" name="txtContraseñaActual" required/>

                <label for="txtContraseñaNueva">Nueva Contraseña</label>
                <input type="password" id="txtContraseñaNueva" name="txtContraseñaNueva" required/>

                <label for="txtConfirmarContraseña">Confirmar Nueva Contraseña</label>
                <input type="password" id="txtConfirmarContraseña" name="txtConfirmarContraseña" required/>

                <button type="submit">Cambiar Contraseña</button>
            </form>
        </div>

    </div>

</body>
</html>
