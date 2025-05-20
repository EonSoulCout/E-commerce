<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.products.login.Usuario" %>
<%@ page import="com.products.login.UsuarioDAO" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.Part" %>

<%@ page trimDirectiveWhitespaces="true" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String mensajeError = null;
    Usuario nuevoUsuario = null;
    boolean registroExitoso = false;

    // Perfil ID para Clientes (según tu estructura, 2 = cliente)
    final int PERFIL_ID_CLIENTE = 2; 

    try {
        // 1. Obtener parámetros del formulario
        String nombre = request.getParameter("txtNombre");
        String cedula = request.getParameter("txtCedula");
        String correo = request.getParameter("txtCorreo");
        String contrasena = request.getParameter("txtContraseña"); // ¡IMPORTANTE: Hashear antes de guardar!
        String estadoCivil = request.getParameter("cmbECivil");
        String residencia = request.getParameter("rdResidencia"); // Valor de radio button
        String colorFavorito = request.getParameter("colorFavorito");
        String fechaNacimientoStr = request.getParameter("fecha"); // Formato "YYYY-MM"
        
     // ... justo después de obtener todos los request.getParameter(...)
        System.out.println("----- DEBUG: Valores recibidos en registro_cliente_process.jsp -----");
        System.out.println("Nombre: [" + nombre + "]");
        System.out.println("Cedula: [" + cedula + "]");
        System.out.println("Correo: [" + correo + "]");
        System.out.println("Contrasena: [" + contrasena + "]"); // Cuidado al imprimir contraseñas, incluso en debug
        System.out.println("Estado Civil: [" + estadoCivil + "]");
        System.out.println("Residencia: [" + residencia + "]");
        System.out.println("Color Favorito: [" + colorFavorito + "]");
        System.out.println("Fecha Nacimiento String: [" + fechaNacimientoStr + "]");
        System.out.println("----- FIN DEBUG -----");

        // También puedes probar cada condición individualmente para ver cuál es true:
        if (nombre == null || nombre.trim().isEmpty()) System.out.println("DEBUG: Nombre está fallando la validación.");
        if (cedula == null || cedula.trim().isEmpty()) System.out.println("DEBUG: Cédula está fallando la validación.");
        if (correo == null || correo.trim().isEmpty()) System.out.println("DEBUG: Correo está fallando la validación.");
        if (contrasena == null || contrasena.trim().isEmpty()) System.out.println("DEBUG: Contraseña está fallando la validación.");
        if (estadoCivil == null || estadoCivil.isEmpty()) System.out.println("DEBUG: Estado Civil está fallando la validación (valor actual: " + estadoCivil + ").");
        if (residencia == null || residencia.trim().isEmpty()) System.out.println("DEBUG: Residencia está fallando la validación.");
        if (colorFavorito == null || colorFavorito.trim().isEmpty()) System.out.println("DEBUG: Color Favorito está fallando la validación.");
        if (fechaNacimientoStr == null || fechaNacimientoStr.trim().isEmpty()) System.out.println("DEBUG: Fecha Nacimiento String está fallando la validación.");	

     // 2. Validación básica de campos obligatorios (puedes expandir esto)
        if (nombre == null || nombre.trim().isEmpty() ||
            cedula == null || cedula.trim().isEmpty() ||
            correo == null || correo.trim().isEmpty() ||
            contrasena == null || contrasena.trim().isEmpty() || 
            estadoCivil == null || estadoCivil.isEmpty() ||
            residencia == null || residencia.trim().isEmpty() ||
            colorFavorito == null || colorFavorito.trim().isEmpty() ||
            fechaNacimientoStr == null || fechaNacimientoStr.trim().isEmpty()) {
            mensajeError = "Todos los campos marcados con * son obligatorios y deben ser completados.";
        }

        // 3. Procesar la subida de la foto (solo si no hay errores previos)
        Part filePart = null;
        byte[] fotoBytes = null;
        if (mensajeError == null) {
            filePart = request.getPart("fileFoto"); // "fileFoto" es el name del input type="file"
            if (filePart != null && filePart.getSize() > 0) {
                // Validar tipo de archivo (opcional pero recomendado)
                String contentType = filePart.getContentType();
                if (!contentType.equals("image/jpeg") && !contentType.equals("image/png") && !contentType.equals("image/jpg")) {
                    mensajeError = "Formato de foto no válido. Solo se permiten JPG, JPEG o PNG.";
                } else {
                    try (InputStream fileContent = filePart.getInputStream();
                         ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
                        int nRead;
                        byte[] data = new byte[1024]; // Buffer de lectura
                        while ((nRead = fileContent.read(data, 0, data.length)) != -1) {
                            buffer.write(data, 0, nRead);
                        }
                        buffer.flush();
                        fotoBytes = buffer.toByteArray();
                    }
                }
            } else {
                // Si el campo 'fileFoto' es 'required' en el HTML, esto no debería ocurrir
                // a menos que el navegador no fuerce el 'required' o se manipule el form.
                mensajeError = "La foto de perfil es obligatoria.";
            }
        }
        
        // 4. Convertir y validar fecha de nacimiento (solo si no hay errores previos)
        Date fechaNacimiento = null;
        if (mensajeError == null) {
            if (fechaNacimientoStr != null && !fechaNacimientoStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                    sdf.setLenient(false); // Para que no acepte fechas inválidas como "2023-13"
                    fechaNacimiento = sdf.parse(fechaNacimientoStr); // Se guarda el primer día del mes seleccionado
                } catch (java.text.ParseException e) {
                    System.err.println("Error al parsear fecha de nacimiento: " + e.getMessage());
                    mensajeError = "Formato de fecha de nacimiento inválido. Debe ser YYYY-MM.";
                }
            } else {
                 // Ya cubierto por la validación general de campos, pero por si acaso.
                mensajeError = "La fecha de nacimiento es obligatoria.";
            }
        }

        // 5. Si no hay errores hasta ahora, proceder con la lógica de negocio
        if (mensajeError == null) {
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            // 5a. Verificar si el correo ya existe ANTES de intentar registrar
            Usuario usuarioExistente = usuarioDAO.obtenerUsuarioPorCorreo(correo);
            if (usuarioExistente != null) {
                mensajeError = "El correo electrónico '" + correo + "' ya está registrado. Por favor, intente con otro.";
            } else {
                // 5b. Crear el objeto Usuario
                // ¡¡¡DEBES HASHEAR LA CONTRASEÑA ANTES DE PASARLA AL CONSTRUCTOR!!!
                // Ejemplo (necesitarás una librería como BCrypt y un método para hashear):
                // String contrasenaHasheada = MiClaseDeSeguridad.hashearContrasena(contrasena);
                // Por ahora, se pasa en texto plano, lo cual es INSEGURO.
                nuevoUsuario = new Usuario(
                    nombre,
                    cedula,
                    correo,
                    contrasena, // ¡¡¡PELIGRO: Contraseña en texto plano!!!
                    estadoCivil,
                    residencia,
                    colorFavorito,
                    fechaNacimiento,
                    fotoBytes,
                    PERFIL_ID_CLIENTE // Asignación del perfil de cliente
                );

                // 5c. Intentar registrar el usuario
                registroExitoso = usuarioDAO.registrarUsuario(nuevoUsuario, PERFIL_ID_CLIENTE);

                if (registroExitoso) {
                    // 5d. Registro exitoso: Iniciar sesión y redirigir
                    session.setAttribute("usuario", nuevoUsuario); // Guardar el objeto Usuario completo en sesión
                    response.sendRedirect("welcome.jsp");
                    return; // MUY IMPORTANTE: Detener la ejecución del JSP para evitar problemas con la redirección
                } else {
                    mensajeError = "No se pudo completar el registro en la base de datos. Por favor, intente más tarde.";
                }
            }
        }

    } catch (IllegalStateException e) {
        // Esto puede ocurrir si el archivo subido excede el tamaño máximo configurado.
        e.printStackTrace();
        mensajeError = "Error con la subida del archivo: el archivo podría ser demasiado grande o estar corrupto.";
    } catch (Exception e) {
        // Captura general para cualquier otro error inesperado
        e.printStackTrace(); // Es bueno loguear esto en la consola del servidor
        mensajeError = "Ocurrió un error inesperado durante el proceso de registro. Detalles: " + e.getMessage();
    }

    // 6. Si hubo algún error durante el proceso, redirigir de nuevo al formulario de registro con un mensaje
    if (mensajeError != null) {
        session.setAttribute("errorRegistro", mensajeError);
        response.sendRedirect("sing_up.jsp");
        // No necesitas un 'return' aquí porque es el final del script.
    }
%>