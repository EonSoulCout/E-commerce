<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.products.login.Usuario" %>
<%@ page import="com.products.login.UsuarioDAO" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nexared - Inicio de Sesión</title>
    <link href="css/des_login.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<div class="app-container">
    <header>
        <div class="logo">
            <span class="logo-icon"><i class="fas fa-network-wired"></i></span>
            <span class="logo-text">Nexared</span>
        </div>
        <nav>
            <a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> Inicio</a>
        </nav>
    </header>

    <main>
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <div class="auth-logo">
                        <i class="fas fa-network-wired"></i>
                    </div>
                    <h1>Iniciar Sesión</h1>
                    <p>Ingresa a tu cuenta para acceder al panel</p>
                </div>
                
                <form action="login_process.jsp" method="POST" class="auth-form">
                    <!-- Campo de correo -->
                    <div class="form-group">
                        <label for="correo">Correo electrónico</label>
                        <div class="input-group">
                            <span class="input-icon"><i class="fas fa-envelope"></i></span>
                            <input type="email" id="correo" name="correo" placeholder="tucorreo@dominio.com" required />
                        </div>
                    </div>

                    <!-- Campo de contraseña -->
                    <div class="form-group">
                        <label for="contrasena">Contraseña</label>
                        <div class="input-group">
                            <span class="input-icon"><i class="fas fa-lock"></i></span>
                            <input type="password" id="contrasena" name="contrasena" placeholder="••••••••" required />
                            <span class="toggle-password" onclick="togglePassword()">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>

                    <div class="form-options">
                        <a href="#" class="forgot-link">¿Olvidaste tu contraseña?</a>
                    </div>

                    <!-- Mostrar mensaje de error si es necesario -->
                    <%
                    String error = request.getParameter("error");
                    if (error != null && error.equals("credenciales_incorrectas")) {
                    %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        Credenciales incorrectas. Intenta nuevamente.
                    </div>
                    <%
                    } else if (error != null && error.equals("campos_vacios")) {
                    %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        Por favor, completa todos los campos.
                    </div>
                    <%
                    }
                    %>

                    <button type="submit" class="btn-primary">
                        <span>Acceder</span>
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </form>

                <div class="auth-footer">
                    <p>¿No tienes una cuenta? <a href="user_sign_up.jsp" class="register-link">Crear cuenta</a></p>
                </div>
            </div>
        </div>

        <div class="auth-illustration">
            <div class="illustration-content">
                <h2>Plataforma de Gestión Nexared</h2>
                <p>Soluciones integrales para la administración de redes empresariales</p>
                <div class="feature-list">
                    <div class="feature-item">
                        <i class="fas fa-shield-alt"></i>
                        <div>
                            <h4>Seguridad Avanzada</h4>
                            <p>Protección de última generación para tus datos</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-tachometer-alt"></i>
                        <div>
                            <h4>Alto Rendimiento</h4>
                            <p>Infraestructura optimizada para máxima velocidad</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-chart-line"></i>
                        <div>
                            <h4>Analítica en Tiempo Real</h4>
                            <p>Monitoreo detallado de tu red</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
function togglePassword() {
    const passwordField = document.getElementById('contrasena');
    const toggleIcon = document.querySelector('.toggle-password i');
    
    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    } else {
        passwordField.type = 'password';
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    }
}
</script>

</body>
</html>