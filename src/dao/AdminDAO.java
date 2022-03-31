package dao;

import dominio.AdminInfo;
import dominio.Usuario;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;


public class AdminDAO {
    private static String QUERY_AGREGAR = "INSERT INTO usr_info(fecha, user,visitas,busquedas,likes,mensajes, masvisitado, mascontactado, likeados,contactados,visitados) VALUES (NOW(),?,?,?,?,?,?,?,?,?,?)";
    private static String QUERY_ACTIVIDAD = "SELECT * FROM usr_info";
   private static String QUERY_TODOS="SELECT user,nombre, apellidos, fecha, ciudad, tipo_user, fecha_alta FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user!= ? and U.tipo_user=\"usuario\"";
   private static String QUERY_BORRAR="DELETE from usr_info";
    //añade actividad del user de sesión
    public static boolean agregarActividad(String usuario, int visitas, int busquedas, int likes, int mensajes, String masvisitado, String mascontactado, String likeados,String contactados, String visitados) {
        boolean agregado = false;
        try {

            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_AGREGAR);
                ps.setString(1, usuario);
                ps.setInt(2, visitas);
                ps.setInt(3, busquedas);
                ps.setInt(4, likes);
                ps.setInt(5, mensajes);
                ps.setString(6, masvisitado);
                ps.setString(7, mascontactado);
                ps.setString(8, likeados);
                ps.setString(9, contactados);
                ps.setString(10, visitados);
                ps.execute();
                agregado = true;
                ps.close();

            }
                con.close();

        } catch (SQLException e) {
        	agregado = false;
        	e.printStackTrace();
        }
        return agregado;
    }
    public static ArrayList<AdminInfo> getActividad(){
    	ArrayList<AdminInfo> actividad = new ArrayList<AdminInfo>();

        try {

            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_ACTIVIDAD);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                	Date fecha = rs.getDate("fecha");
                	String user = rs.getString("user");
                	int visitas = rs.getInt("visitas");
                	int busquedas = rs.getInt("busquedas");
                	int likes = rs.getInt("likes");
                	int mensajes = rs.getInt("mensajes");
                	AdminInfo info = new AdminInfo(fecha, user, visitas, busquedas, likes, mensajes);
                	info.setMasvisitado(rs.getString("masvisitado"));
                	info.setMascontactado(rs.getString("mascontactado"));
                	info.setLikeados(rs.getString("likeados"));
                	info.setContactados(rs.getString("contactados"));
                	info.setVisitados(rs.getString("visitados"));
                	actividad.add(info);
                }
                
                ps.close();

            }
                con.close();

        } catch (SQLException e) {
        	
        	e.printStackTrace();
        }
    	return actividad;
    }

    public static Collection<Usuario> AdminUsuarios(Usuario usuario) {
        Usuario u=null;
        ArrayList<Usuario> lista = new ArrayList<Usuario>();
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {

                PreparedStatement ps = con.prepareStatement(QUERY_TODOS);
                ps.setString(1, usuario.getUser());
                ResultSet rs = ps.executeQuery();
                while (rs.next()) //devuelve muchos usuarios
                {
                    String user = rs.getString("user");
                    String nombre = rs.getString("nombre");
                    String apellidos = rs.getString("apellidos");
                    String fecha = rs.getString("fecha");
                    String ciudad = rs.getString("ciudad");
                    String tipo=rs.getString("tipo_user");
                    Date fecha_alta=rs.getDate("fecha_alta");

                    u = new Usuario(user, nombre, apellidos, fecha, ciudad);
                    u.setImagen(UsuarioDAO.getImagenPerfil(u));
                    u.setTipo(tipo);
                    u.setFecha_alta(fecha_alta);
                    lista.add(u);
                }
                rs.close();
                ps.close();
            }
            con.close();
        }catch (SQLException e) {
            lista = null;
            e.printStackTrace();
        }
        return lista;
    }

    public static boolean borrarActividad() {
        boolean borrado = false;
        try {

            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_BORRAR);
                ps.execute();
                borrado = true;
                ps.close();

            }
            con.close();

        } catch (SQLException e) {
            borrado = false;
            e.printStackTrace();
        }
        return borrado;
    }

}
