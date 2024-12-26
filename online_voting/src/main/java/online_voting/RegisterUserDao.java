package online_voting;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class RegisterUserDao{
	Dao dao=new Dao();
	public String insertUser(String name,String email,String pass) {
		
		String res = "Data entered successfully.";
	    Connection con = null;
	    PreparedStatement ps = null;
	    
	    try {
	        dao.loadDriver();  // Ensure that JDBC driver is loaded
	        con = dao.getConnection();  // Get the connection to the database

	        String sql = "INSERT INTO users (NAME,EMAIL,PASSWORD) VALUES (?, ?, ?)";
	        
	        ps = con.prepareStatement(sql);
	        ps.setString(1, name);
	        ps.setString(2, email);
	        ps.setString(3, pass);

	        int rowsAffected = ps.executeUpdate();  // Execute the insert operation

	        if (rowsAffected > 0) {
	            res = "user inserted successfully.";
	        } else {
	            res = "No rows affected. user not inserted.";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();  // Log the exception for debugging
	        res = "Data not entered. Error: " + e.getMessage();  // Return specific error message
	    } finally {
	        try {
	            // Close resources in the finally block to ensure they are always closed
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();  // Log any exceptions while closing resources
	        }
	    }

	    return res;
	}
	public  Map<String,Object> validateLogin(String uid, String pass) {
		Dao dao=new Dao();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    Map<String,Object> userDetail=new HashMap<>();

	    try {
	        // Get the connection
	    	dao.loadDriver();
	        conn = dao.getConnection();

	        // SQL query to check if the userId and password match
	        String sql = "SELECT * FROM users WHERE (NAME = ? OR EMAIL = ? ) AND PASSWORD= ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, uid);
	        stmt.setString(2, uid);
	        stmt.setString(3, pass);
	        // Execute the query
	        rs = stmt.executeQuery();

	        // If the result has at least one row, the credentials are correct
	        if (rs.next() && rs.getInt(1) > 0) {
	        	 int id = rs.getInt("ID");
	             String name = rs.getString("NAME");
	             String email=rs.getString("EMAIL");
	             userDetail.put("uid",id);
	             userDetail.put("username", name);
	             userDetail.put("emali", email);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();

	    } finally {
	        // Close resources
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }

	    return userDetail;
	}
	
	public boolean updateUser(int userId, String username, String email, String password) throws Exception {
        dao.loadDriver();
        Connection con = dao.getConnection();
        String query = "UPDATE users SET NAME = ?, EMAIL = ?, PASSWORD = ? WHERE ID = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, userId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            throw new Exception("Database error: " + e.getMessage());
        }
    }
	
		
}