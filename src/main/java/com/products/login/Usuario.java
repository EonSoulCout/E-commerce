package com.products.login;

import java.util.Date;

public class Usuario {
    private String nombre;
    private String cedula;
    private String correo;
    private String contrasena;
    private String estadoCivil;
    private String residencia;
    private String colorFavorito;
    private Date fechaNacimiento;
    private byte[] foto; // Foto del usuario
    private int perfilId; // Este es el campo id_per que indica el perfil (1=admin, 2=cliente, 3=empleado)

    // Constructor
    public Usuario(String nombre, String cedula, String correo, String contrasena, String estadoCivil,
                   String residencia, String colorFavorito, Date fechaNacimiento, byte[] foto, int perfilId) {
        this.nombre = nombre;
        this.cedula = cedula;
        this.correo = correo;
        this.contrasena = contrasena;
        this.estadoCivil = estadoCivil;
        this.residencia = residencia;
        this.colorFavorito = colorFavorito;
        this.fechaNacimiento = fechaNacimiento;
        this.foto = foto;
        this.perfilId = perfilId; // Asignación del perfilId
    }

    // Getters y setters para todos los campos
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }

    public String getEstadoCivil() { return estadoCivil; }
    public void setEstadoCivil(String estadoCivil) { this.estadoCivil = estadoCivil; }

    public String getResidencia() { return residencia; }
    public void setResidencia(String residencia) { this.residencia = residencia; }

    public String getColorFavorito() { return colorFavorito; }
    public void setColorFavorito(String colorFavorito) { this.colorFavorito = colorFavorito; }

    public Date getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(Date fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public byte[] getFoto() { return foto; }
    public void setFoto(byte[] foto) { this.foto = foto; }

    public int getPerfilId() { return perfilId; } // Getter para perfilId
    public void setPerfilId(int perfilId) { this.perfilId = perfilId; } // Setter para perfilId
}
