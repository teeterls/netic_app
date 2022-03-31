package dominio;

import java.awt.*;
import java.util.Date;

public class Usuario {

    private String user;
    private String pwd;
    private String nombre;
    private String apellidos;
    private String sexo;
    private String fecha;
    private String email;
    private String preferencia;
    private String descripcion;
    private String tipo;
    
    private String altura;
    private String fisico;
    private String ciudad;
    private String hijos;
    private String civil;
    
    private int edad;
    
    private String imagen;
    private Date fecha_alta;

    public Usuario(String user, String nombre, String apellidos, String sexo, String fecha, String preferencia, String descripcion, String altura,String fisico, String ciudad, String hijos, String civil)
    {
        this.user=user;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.fecha = fecha;
        this.preferencia = preferencia;
        this.descripcion = descripcion;
        this.altura = altura;
        this.fisico = fisico;
        this.ciudad = ciudad;
        this.hijos = hijos;
        this.civil = civil;

    }


    public Usuario(String user, String pwd, String nombre, String apellidos, String sexo, String fecha, String email, String preferencia, String descripcion, String tipo, String altura, String fisico, String ciudad, String hijos, String civil) {
        this.user = user;
        this.pwd = pwd;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.fecha = fecha;
        this.email = email;
        this.preferencia = preferencia;
        this.descripcion = descripcion;
        this.altura = altura;
        this.fisico = fisico;
        this.ciudad = ciudad;
        this.hijos = hijos;
        this.civil = civil;

    }


    public Usuario (String user, String pwd)
    {
        this.user=user;
        this.pwd=pwd;
    }

    public Usuario(String user, String nombre, String apellidos, String fecha, String ciudad, String tipo) {
        this.user=user;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.fecha = fecha;
        this.ciudad = ciudad;
        this.tipo=tipo;
    }

    public Usuario(String user, String nombre, String apellidos, String fecha, String ciudad) {
        this.user=user;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.fecha = fecha;
        this.ciudad = ciudad;
    }

    public Usuario(String user, String pwd, String nombre, String apellidos, String sexo, String fecha, String email, String preferencia, String descripcion) {
        this.user = user;
        this.pwd = pwd;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.fecha = fecha;
        this.email=email;
        this.preferencia = preferencia;
        this.descripcion = descripcion;
    }
    
    public Usuario(String user, String pwd, String nombre, String apellidos, String sexo, String fecha, String email, String preferencia, String descripcion, String tipo) {
        this.user = user;
        this.pwd = pwd;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.sexo = sexo;
        this.fecha = fecha;
        this.email=email;
        this.preferencia = preferencia;
        this.descripcion = descripcion;
        this.tipo = tipo;
    }

    public void setUser (String user)

    {
        this.user=user;
    }

    public String getUser()
    {
        return user;
    }

    public void setPwd (String pwd)
    {
        this.pwd=pwd;
    }

    public String getPwd()
    {
        return pwd;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPreferencia() {
        return preferencia;
    }

    public void setPreferencia(String preferencia) {
        this.preferencia = preferencia;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

	public String getAltura() {
		return altura;
	}

	public void setAltura(String altura) {
		this.altura = altura;
	}

	public String getFisico() {
		return fisico;
	}

	public void setFisico(String fisico) {
		this.fisico = fisico;
	}

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public String getCivil() {
		return civil;
	}

	public void setCivil(String civil) {
		this.civil = civil;
	}

	public String getHijos() {
		return hijos;
	}

	public void setHijos(String hijos) {
		this.hijos = hijos;
	}
	
	public void setInfoExtra(String altura, String fisico, String ciudad, String hijos, String civil) {
		this.setAltura(altura);
		this.setFisico(fisico);
		this.setCiudad(ciudad);
		this.setHijos(hijos);
		this.setCivil(civil);
	}

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}


	public String getTipo() {
		return tipo;
	}


	public void setTipo(String tipo) {
		this.tipo = tipo;
	}


    public Date getFecha_alta() {
        return fecha_alta;
    }

    public void setFecha_alta(Date fecha_alta) {
        this.fecha_alta = fecha_alta;
    }


	public int getEdad() {
		return edad;
	}


	public void setEdad(int edad) {
		this.edad = edad;
	}
}
