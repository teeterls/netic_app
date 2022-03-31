package dominio;

public class Busqueda {

    private String edad1;
    private String edad2;
    private String ciudad;
    private String altura1;
    private String altura2;
    private String hijos;
    private String civil;
    private String fisico;
    private String[] aficiones;
    private int secuencia;

    //constructor simple.
    public Busqueda() {

    }
    //constructor completo.
    /*public Busqueda(String edad1, String edad2, String ciudad, String altura1, String altura2, String hijos, String civil, String fisico, String[] aficiones) {
        this.edad1 = edad1;
        this.edad2 = edad2;
        this.ciudad = ciudad;
        this.altura1 = altura1;
        this.altura2 = altura2;
        this.hijos = hijos;
        this.civil = civil;
        this.fisico = fisico;
        this.aficiones = aficiones;
        this.aficiones = aficiones;
    }*/

    public void setBusqueda(String edad1, String edad2, String ciudad, String altura1, String altura2, String hijos, String civil, String fisico, String[] aficiones) {
        this.edad1 = edad1;
        this.edad2 = edad2;
        this.ciudad = ciudad;
        this.altura1 = altura1;
        this.altura2 = altura2;
        this.hijos = hijos;
        this.civil = civil;
        this.fisico = fisico;
        this.aficiones = aficiones;
        this.aficiones = aficiones;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public String getEdad1() {
        return edad1;
    }

    public void setEdad1(String edad1) {
        this.edad1 = edad1;
    }

    public String getEdad2() {
        return edad2;
    }

    public void setEdad2(String edad2) {
        this.edad2 = edad2;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getAltura1() {
        return altura1;
    }

    public void setAltura1(String altura1) {
        this.altura1 = altura1;
    }

    public String getAltura2() {
        return altura2;
    }

    public void setAltura2(String altura2) {
        this.altura2 = altura2;
    }

    public String getHijos() {
        return hijos;
    }

    public void setHijos(String hijos) {
        this.hijos = hijos;
    }

    public String getCivil() {
        return civil;
    }

    public void setCivil(String civil) {
        this.civil = civil;
    }

    public String getFisico() {
        return fisico;
    }

    public void setFisico(String fisico) {
        this.fisico = fisico;
    }

    public String[] getAficiones() {
        return aficiones;
    }

    public void setAficiones(String[] aficiones) {
        this.aficiones = aficiones;
    }

}
