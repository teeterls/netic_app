package dao;

import dominio.Usuario;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.*;
import java.util.Base64;

import javax.servlet.http.Part;

public class UsuarioDAO {
    private static String QUERY_AGREGAR = "INSERT INTO usuario(user,password,nombre,apellidos,sexo,fecha,email,preferencia,descripcion, tipo_user , fecha_alta) VALUES (?,?,?,?,?,?,?,?,?,?, NOW())";
    private static String QUERY_BUSCAR = "SELECT * FROM usuario WHERE user = ? AND password = ?";
    private static String QUERY_INSERTAR = "INSERT INTO usr_extra(userextra, estatura, fisico, ciudad, hijos, civil) VALUES (?,?,?,?,?,?)";
    private static String QUERY_INFOPERFIL = "SELECT user, password, nombre, apellidos, sexo, fecha, email, preferencia, descripcion, tipo_user, estatura, fisico, ciudad, hijos, civil FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user= ? ";
    private static String QUERY_UPDATE_USER = "UPDATE usuario SET nombre=?, apellidos=?, email=?, descripcion=?, password=?, preferencia=? WHERE user=?";
    private static String QUERY_UPDATE_USEREXTRA = "UPDATE usr_extra SET estatura=?, fisico=?, ciudad=?, hijos=?, civil=? WHERE userextra=?";
    private static String QUERY_UPDATE_IMGPERFIL = "UPDATE usr_extra SET user_img=? WHERE userextra=?";
    private static String QUERY_GET_IMGPERFIL = "SELECT user_img from usr_extra where userextra=?";
    private static String QUERY_INFOPUBLICA= "SELECT user, nombre, apellidos, sexo, fecha, preferencia, descripcion, estatura, fisico, ciudad, hijos, civil FROM pat_3.usuario U , pat_3.usr_extra E where U.user= E.userextra and U.user= ?";
    private static String QUERY_ELIMINAR_USER = "DELETE FROM usuario WHERE user = ?";
    private static String QUERY_ELIMINAR_USEREXTRA = "DELETE FROM usr_extra WHERE userextra = ?";
    private static String QUERY_UPDATE_PERMISO = "UPDATE usuario SET tipo_user = ? WHERE user=?";
    private static String QUERY_ELIMINAR_ACTIVIDAD= " DELETE FROM usr_info WHERE user=?";

    public static boolean agregarUsuario(Usuario usuario) {
        boolean agregado = false;
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_AGREGAR);
                ps.setString(1, usuario.getUser());
                ps.setString(2, usuario.getPwd());
                ps.setString(3, usuario.getNombre());
                ps.setString(4, usuario.getApellidos());
                ps.setString(5, usuario.getSexo());
                ps.setString(6, usuario.getFecha());
                ps.setString(7, usuario.getEmail());
                ps.setString(8, usuario.getPreferencia());
                ps.setString(9, usuario.getDescripcion());
                ps.setString(10, usuario.getTipo());
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

    public static boolean buscarUsuario(Usuario usuario) {
        boolean existe = false;
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_BUSCAR);
                ps.setString(1, usuario.getUser());
                ps.setString(2, usuario.getPwd());
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                    existe = true;
                else
                    existe = false;

            }
            con.close();
        } catch (SQLException e) {
            existe = false;
            e.printStackTrace();
        }
        return existe;
    }

    public static boolean insertarInfoExtra(Usuario usuario) {
        boolean insertado = false;
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_INSERTAR);
                ps.setString(1, usuario.getUser());
                ps.setString(2, usuario.getAltura());
                ps.setString(3, usuario.getFisico());
                ps.setString(4, usuario.getCiudad());
                ps.setString(5, usuario.getHijos());
                ps.setString(6, usuario.getCivil());
                ps.execute();
                insertado = true;
                ps.close();
            }
            con.close();
        } catch (SQLException e) {
            insertado = false;
            e.printStackTrace();
        }
        return insertado;
    }

    public static Usuario getInfoCompleta(Usuario usuario) {
        Usuario usuarioCompleto = null;
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_INFOPERFIL);
                ps.setString(1, usuario.getUser());
                ResultSet rs = ps.executeQuery();
                //solo devuelve un usuario ya que user es parametro unico
                if (rs.next()) {
                    String user= rs.getString("user") ;
                    String pwd= rs.getString("password");
                    String nombre=rs.getString("nombre");
                    String apellidos=rs.getString("apellidos");
                    String sexo=rs.getString("sexo");
                    String fecha=rs.getString("fecha");
                    String email=rs.getString("email");
                    String preferencia=rs.getString("preferencia");
                    String descripcion=rs.getString("descripcion");
                    String tipo=rs.getString("tipo_user");
                    String altura=rs.getString("estatura");
                    String fisico=rs.getString("fisico");
                    String ciudad=rs.getString("ciudad");
                    String hijos=rs.getString("hijos");
                    String civil=rs.getString("civil");
                    String imagen = getImagenPerfil(usuario);

                    usuarioCompleto = new Usuario(user,pwd,nombre,apellidos,sexo,fecha,email,preferencia,descripcion,tipo,altura,fisico,ciudad,hijos,civil);
                    usuarioCompleto.setImagen(imagen);
                    usuarioCompleto.setTipo(tipo);
                } else
                    usuarioCompleto = null;
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarioCompleto;

    }
    
    public static boolean updateUsuario(Usuario newUser){
    	InputStream inputStream = null;
    	boolean updated = false;
    	try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_UPDATE_USER);
                ps.setString(1, newUser.getNombre());
                ps.setString(2, newUser.getApellidos());
                ps.setString(3, newUser.getEmail());
                ps.setString(4, newUser.getDescripcion());
                ps.setString(5, newUser.getPwd());
                ps.setString(6, newUser.getPreferencia());
                ps.setString(7, newUser.getUser());
                ps.execute();
                ps.close();
                
                ps = con.prepareStatement(QUERY_UPDATE_USEREXTRA);
                ps.setString(1, newUser.getAltura());
                ps.setString(2, newUser.getFisico());
                ps.setString(3, newUser.getCiudad());
                ps.setString(4, newUser.getHijos());
                ps.setString(5, newUser.getCivil());
                ps.setString(6, newUser.getUser());
                ps.execute();
                ps.close();
                updated = true;
                con.close();
                
                
            }
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return updated;
    }
    
    public static boolean permisoUsuario(Usuario user, String permiso){
    	boolean cambioPermiso = false;
    	try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_UPDATE_PERMISO);
                ps.setString(1, permiso);
                ps.setString(2, user.getUser());
                ps.execute();
                ps.close();
                cambioPermiso = true;
                con.close();
                
            }
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return cambioPermiso;
    }

    
    public static boolean updateFoto(Part fotoPart, Usuario user) {
    	boolean updated = false;
    	try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
            	InputStream foto = fotoPart.getInputStream();
            	PreparedStatement ps = con.prepareStatement(QUERY_UPDATE_IMGPERFIL);
            	ps.setBlob(1, foto);
            	ps.setString(2, user.getUser());
            	ps.execute();
            	updated= true;
            	con.close();
            }
        } catch(SQLException e) {
        	e.printStackTrace();
        } catch(IOException ioe) {
        	
        }
    	return updated;
    }
    
    public static boolean eliminarUsuario(Usuario user){
    	boolean eliminado = false;
    	try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_ELIMINAR_USER);
                ps.setString(1, user.getUser());
                ps.execute();
                ps.close();

                ps = con.prepareStatement(QUERY_ELIMINAR_USEREXTRA);
                ps.setString(1, user.getUser());
                ps.execute();
                ps.close();

                ps=con.prepareStatement(QUERY_ELIMINAR_ACTIVIDAD);
                ps.setString(1, user.getUser());
                ps.execute();
                eliminado = true;
                ps.close();
                con.close();
                
            }
    	} catch (SQLException e) {
    		e.printStackTrace();
    		eliminado=false;
    	}
    	return eliminado;
    }
    
    public static String getImagenPerfil(Usuario u) {

    	String base64Image = null;
    	Blob image;

    	try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
            	PreparedStatement ps = con.prepareStatement(QUERY_GET_IMGPERFIL);
            	ps.setString(1, u.getUser());
            	ResultSet rs = ps.executeQuery();
            	if(rs.next()) {
            		image = rs.getBlob(1);
            		if(image!= null) {
	            		InputStream inputStream = image.getBinaryStream();
	            		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	            		byte[] buffer = new byte[4096];
	            		int bytesRead = -1;
	            		 
	            		while ((bytesRead = inputStream.read(buffer)) != -1) {
	            		    outputStream.write(buffer, 0, bytesRead);
	            		}
	            		 
	            		byte[] imageBytes = outputStream.toByteArray();

	            		base64Image = Base64.getEncoder().encodeToString(imageBytes);

	            		inputStream.close();
	            		outputStream.close();
            		}
            	}

            	con.close();
            }
        } catch(SQLException e) {
        	e.printStackTrace();
        } catch(IOException ioe) {
        	ioe.printStackTrace();
        }
    	return base64Image;
    }

    public static Usuario verPerfil(String usuario)
    {
        Usuario usuariopublico= null;
        try {
            Conexion c = new Conexion();
            Connection con = c.getConexion();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(QUERY_INFOPUBLICA);
                ps.setString(1, usuario);
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                {
                    String user=rs.getString("user");
                        String nombre=rs.getString("nombre");
                        String apellidos=rs.getString("apellidos");
                        String sexo=rs.getString("sexo");
                        String fecha=rs.getString("fecha");
                        String preferencia=rs.getString("preferencia");
                        String descripcion=rs.getString("descripcion");
                        String altura=rs.getString("estatura");
                        String fisico=rs.getString("fisico");
                        String ciudad=rs.getString("ciudad");
                        String hijos=rs.getString("hijos");
                        String civil=rs.getString("civil");
                    // String imagen = getImagenPerfil(usuario);
                       // usuarioCompleto.setImagen(imagen);
                    usuariopublico=new Usuario (user,nombre,apellidos,sexo,fecha,preferencia,descripcion,altura,fisico,ciudad,hijos,civil);
                    usuariopublico.setImagen(UsuarioDAO.getImagenPerfil(usuariopublico));
                    } else
                    usuariopublico=null;
                ps.close();
                rs.close();
            }
            con.close();
        } catch (SQLException e) {
            usuariopublico=null;
            e.printStackTrace();
        }
        return usuariopublico;
    }

    
}



