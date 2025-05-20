<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Panel de Administración</title>
  <link href="css/des_login.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    .admin-options {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin-top: 30px;
    }
    
    .admin-btn {
      padding: 18px;
      font-size: 1.1em;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }
    
    .admin-btn i {
      font-size: 1.3em;
    }
    
    .welcome-message {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
      font-size: 1.2em;
    }
  </style>
</head>
<body>

<header>
  Nexared - Panel de Administración
</header>

<div class="signup-container login-container">
  <h2>Opciones de Administración</h2>
  
  <div class="welcome-message">
    Bienvenido, <%= session.getAttribute("nombre") != null ? session.getAttribute("nombre") : "Administrador" %>
  </div>

  <div class="admin-options">
    <!-- Botón para registrar empleados/administradores -->
    <button class="admin-btn" onclick="window.location.href='admin_dashboard.jsp'">
      <i>👥</i> Registrar Empleados/Administradores
    </button>
    
    <!-- Botón para ver la bitácora -->
    <button class="admin-btn" onclick="window.location.href='admin_bitacora.jsp'">
      <i>📋</i> Ver Bitácora
    </button>
    
    <!-- Botón para cerrar sesión -->
    <button class="admin-btn secondary" onclick="window.location.href='logout.jsp'">
      <i>🚪</i> Cerrar Sesión
    </button>
  </div>
</div>

</body>
</html>