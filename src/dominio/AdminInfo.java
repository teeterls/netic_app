package dominio;

import java.util.Date;

public class AdminInfo {
	private Date fecha;
	private String usuario;
	private int visitas;
	private int busquedas;
	private int likes;
	private int mensajes;
	private String masvisitado;
	private String mascontactado;
	private String likeados;
	private String contactados;
	private String visitados;

	
	public AdminInfo(Date fecha, String usuario, int visitas, int busquedas, int likes, int mensajes) {
		this.setFecha(fecha);
		this.usuario = usuario;
		this.setVisitas(visitas);
		this.setBusquedas(busquedas);
		this.setLikes(likes);
		this.setMensajes(mensajes);
	}

	public String getMasvisitado() {
		return masvisitado;
	}

	public void setMasvisitado(String masvisitado) {
		this.masvisitado = masvisitado;
	}

	public String getMascontactado() {
		return mascontactado;
	}

	public void setMascontactado(String mascontactado) {
		this.mascontactado = mascontactado;
	}

	public String getLikeados() {
		return likeados;
	}

	public void setLikeados(String likeados) {
		this.likeados = likeados;
	}

	public String getContactados() {
		return contactados;
	}

	public void setContactados(String contactados) {
		this.contactados = contactados;
	}

	public String getVisitados() {
		return visitados;
	}

	public void setVisitados(String visitados) {
		this.visitados = visitados;
	}

	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public int getVisitas() {
		return visitas;
	}

	public void setVisitas(int visitas) {
		this.visitas = visitas;
	}

	public int getBusquedas() {
		return busquedas;
	}

	public void setBusquedas(int busquedas) {
		this.busquedas = busquedas;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getMensajes() {
		return mensajes;
	}

	public void setMensajes(int mensajes) {
		this.mensajes = mensajes;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
}
