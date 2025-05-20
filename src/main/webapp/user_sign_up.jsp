<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrarse</title>
  <link href="css/des_login.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <%-- El bloque <style> para .error-message ha sido removido --%>
</head>
<body>
  <header>
    Nexared - Registro de Cliente
  </header>

  <div class="signup-container">
    <form action="registro_cliente_process.jsp" method="post" enctype="multipart/form-data">
      <h2>Formulario de Registro</h2>

      <%
        String errorRegistro = (String) session.getAttribute("errorRegistro");
        if (errorRegistro != null) {
      %>
          <%-- Se usará la clase .error-message definida en des_login.css --%>
          <div class="error-message"><%= errorRegistro %></div>
      <%
          session.removeAttribute("errorRegistro"); 
        }
      %>

      <label for="txtNombre">Nombre</label>
      <input type="text" id="txtNombre" name="txtNombre" required>

      <label for="txtCedula">Cédula</label>
      <input type="text" id="txtCedula" name="txtCedula" maxlength="10" required>

      <label for="txtCorreo">Correo</label>
      <input type="email" id="txtCorreo" name="txtCorreo" placeholder="usuario@nombreProveedor.com" required>

      <label for="txtContraseña">Contraseña</label>
      <input type="password" id="txtContraseña" name="txtContraseña" minlength="8" required>

      <label for="cmbECivil">Estado Civil</label>
      <select id="cmbECivil" name="cmbECivil" required>
        <option value="">Seleccione</option>
        <option value="Soltero">Soltero</option>
        <option value="Casado">Casado</option>
        <option value="Divorciado">Divorciado</option>
        <option value="Viudo">Viudo</option>
      </select>

      <label>Residencia</label>
      <div class="radio-group">
        <div class="radio-option">
          <input type="radio" id="rdSur" name="rdResidencia" value="Sur" required>
          <label for="rdSur">Sur</label>
        </div>
        <div class="radio-option">
          <input type="radio" id="rdNorte" name="rdResidencia" value="Norte">
          <label for="rdNorte">Norte</label>
        </div>
        <div class="radio-option">
          <input type="radio" id="rdCentro" name="rdResidencia" value="Centro">
          <label for="rdCentro">Centro</label>
        </div>
      </div>

      <label for="colorFavorito">Color favorito</label>
      <input type="color" id="colorFavorito" name="colorFavorito" required>

      <label for="fileFoto">Foto</label>
      <input type="file" id="fileFoto" name="fileFoto" accept=".jpg, .jpeg, .png" onchange="mostrarVistaPrevia(this)" required>

      <img id="preview" class="img-preview" src="#" alt="Vista previa" style="display: none;"/>

      <label for="fecha">Fecha de nacimiento</label>
      <input type="month" id="fecha" name="fecha" required>

      <div class="form-buttons">
        <button type="submit">Registrarse</button>
        <button type="reset" class="secondary">Restablecer</button>
        <button type="button" class="secondary" onclick="window.location.href='index.jsp'">Inicio</button>
      </div>
    </form>
  </div>

  <script>
    function mostrarVistaPrevia(input) {
      const preview = document.getElementById('preview');
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          preview.src = e.target.result;
          preview.style.display = "block"; 
        };
        reader.readAsDataURL(input.files[0]);
      } else {
        preview.src = "#"; 
        preview.style.display = "none"; 
      }
    }
  </script>
</body>
</html>